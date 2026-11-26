"""
Download MSHA open data files and load them into the warehouse `raw` schema with dlt.

MSHA publishes each data set as a ZIP holding one pipe-delimited (|) text file.
The files are full extracts (every row, every week), so each load replaces the table.
"""

import csv
import os
import zipfile
from datetime import date
from pathlib import Path

import dlt
import pandas as pd
import requests

BASE_URL = os.getenv("MSHA_BASE_URL", "https://arlweb.msha.gov/OpenGovernmentData/DataSets")

# zip file name on the MSHA site -> table name in the raw schema
DATASETS = {
    "Mines.zip": "msha_mines",
    "Accidents.zip": "msha_accidents",
    "MinesProdQuarterly.zip": "msha_employment_production_quarterly",
}

DATA_DIR = Path(os.getenv("MSHA_DATA_DIR", "/opt/airflow/data/raw/msha"))
CHUNK_ROWS = 50_000  # read big files in pieces so memory stays low


def download(zip_name: str, base_url: str = BASE_URL, data_dir: Path = DATA_DIR) -> Path:
    """Download one ZIP into a dated folder, unzip it, and return the path of the .txt file."""
    target_dir = data_dir / date.today().isoformat()
    target_dir.mkdir(parents=True, exist_ok=True)
    zip_path = target_dir / zip_name

    url = f"{base_url}/{zip_name}"
    print(f"Downloading {url}")
    headers = {"User-Agent": "mining-bi-portfolio (learning project)"}
    with requests.get(url, headers=headers, stream=True, timeout=300) as response:
        response.raise_for_status()
        with open(zip_path, "wb") as f:
            for block in response.iter_content(chunk_size=1024 * 1024):
                f.write(block)
    print(f"Saved {zip_path} ({zip_path.stat().st_size / 1_048_576:.1f} MB)")

    with zipfile.ZipFile(zip_path) as z:
        txt_names = [n for n in z.namelist() if n.lower().endswith(".txt")]
        if len(txt_names) != 1:
            raise ValueError(f"Expected 1 .txt file in {zip_name}, found {txt_names}")
        z.extract(txt_names[0], target_dir)
    txt_path = target_dir / txt_names[0]
    print(f"Unzipped to {txt_path}")
    return txt_path


def read_pipe_file(txt_path: Path):
    """Yield the file in chunks of CHUNK_ROWS rows, every column as text."""
    reader = pd.read_csv(
        txt_path,
        sep="|",
        dtype=str,              # keep everything as text in raw; dbt casts types later
        encoding="latin-1",     # safe choice: latin-1 can decode any byte, so odd characters never crash the load
        quoting=csv.QUOTE_NONE, # treat " as a normal character, since free-text fields can contain stray quotes
        keep_default_na=False,  # keep blanks as blanks, don't guess at NULLs
        chunksize=CHUNK_ROWS,
    )
    for chunk in reader:
        chunk["_source_file"] = txt_path.name
        yield chunk


def load(txt_path: Path, table_name: str) -> int:
    """Load one text file into raw.<table_name>, replacing what was there. Returns rows loaded."""
    pipeline = dlt.pipeline(
        pipeline_name=f"msha_{table_name}",  # one pipeline per table, so parallel loads don't clash
        destination="postgres",  # credentials come from DESTINATION__POSTGRES__CREDENTIALS
        dataset_name="raw",      # dlt's "dataset" is a Postgres schema
    )
    resource = dlt.resource(
        read_pipe_file(txt_path),
        name=table_name,
        write_disposition="replace",
    )
    info = pipeline.run(resource)
    print(info)

    row_counts = pipeline.last_trace.last_normalize_info.row_counts
    rows = row_counts.get(table_name, 0)
    print(f"Loaded {rows:,} rows into raw.{table_name}")
    return rows

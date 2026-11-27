"""
Download the MSHA data sets and load each one into the raw schema.

Runs every Saturday at 10:00 (Johannesburg time). MSHA updates its files on
Friday afternoon, US time, which is Friday night or early Saturday here.
When every data set has loaded, the final task marks the msha_raw_tables asset
as updated, which starts the dbt_build DAG.
"""

from datetime import datetime

from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.sdk import dag, task

from assets import MSHA_RAW
from ingestion import msha


def log_run(pipeline: str, status: str, rows: int | None, message: str) -> None:
    hook = PostgresHook(postgres_conn_id="mining_dw")
    hook.run(
        "INSERT INTO etl.run_log (pipeline, status, rows_loaded, message) VALUES (%s, %s, %s, %s)",
        parameters=(pipeline, status, rows, message),
    )


@dag(
    dag_id="msha_ingestion",
    schedule="0 10 * * 6",  # minute 0, hour 10, any day, any month, Saturday
    start_date=datetime(2026, 1, 1),
    catchup=False,
    max_active_runs=1,
    max_active_tasks=2,  # at most 2 tasks at once, to go easy on laptop memory
    tags=["ingestion", "msha"],
)
def msha_ingestion():

    loads = []

    for zip_name, table_name in msha.DATASETS.items():

        @task(task_id=f"download_{table_name}", retries=2)
        def download(zip_name=zip_name):
            return str(msha.download(zip_name))

        @task(task_id=f"load_{table_name}")
        def load(txt_path, table_name=table_name):
            from pathlib import Path

            rows = msha.load(Path(txt_path), table_name)
            log_run(f"msha_ingestion.{table_name}", "success", rows, f"Loaded from {Path(txt_path).name}")

        loads.append(load(download()))

    @task(outlets=[MSHA_RAW])
    def all_loads_done():
        """Runs only if every load succeeded. Updating the asset starts dbt_build."""
        print(f"All {len(msha.DATASETS)} MSHA data sets loaded")

    loads >> all_loads_done()


msha_ingestion()
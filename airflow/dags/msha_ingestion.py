"""
Download the MSHA data sets and load each one into the raw schema.

One download task and one load task per data set, so a failure in one
data set doesn't stop the others, and you can rerun just the part that failed.
"""

from datetime import datetime

from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.sdk import dag, task

from ingestion import msha


def log_run(pipeline: str, status: str, rows: int | None, message: str) -> None:
    hook = PostgresHook(postgres_conn_id="mining_dw")
    hook.run(
        "INSERT INTO etl.run_log (pipeline, status, rows_loaded, message) VALUES (%s, %s, %s, %s)",
        parameters=(pipeline, status, rows, message),
    )


@dag(
    dag_id="msha_ingestion",
    schedule=None,  # manual for now; Step 7 puts it on a weekly schedule
    start_date=datetime(2026, 1, 1),
    catchup=False,
    max_active_tasks=2,  # at most 2 tasks at once, to go easy on laptop memory
    tags=["ingestion", "msha"],
)
def msha_ingestion():

    for zip_name, table_name in msha.DATASETS.items():

        @task(task_id=f"download_{table_name}", retries=2)
        def download(zip_name=zip_name):
            return str(msha.download(zip_name))

        @task(task_id=f"load_{table_name}")
        def load(txt_path, table_name=table_name):
            from pathlib import Path

            rows = msha.load(Path(txt_path), table_name)
            log_run(f"msha_ingestion.{table_name}", "success", rows, f"Loaded from {Path(txt_path).name}")

        load(download())


msha_ingestion()
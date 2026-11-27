"""
Run the dbt project after fresh MSHA data has landed.

No clock schedule: this DAG starts when msha_ingestion updates the
msha_raw_tables asset. dbt build runs every model, snapshot, seed and test
in dependency order, so a failing test stops bad data reaching the marts.
"""

import os
from datetime import datetime

from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.sdk import dag, task

from assets import MSHA_RAW

DBT_DIR = os.getenv("DBT_PROJECT_DIR", "/opt/airflow/dbt/mining_dw")


def log_run(status: str, message: str) -> None:
    hook = PostgresHook(postgres_conn_id="mining_dw")
    hook.run(
        "INSERT INTO etl.run_log (pipeline, status, message) VALUES (%s, %s, %s)",
        parameters=("dbt_build", status, message),
    )


@dag(
    dag_id="dbt_build",
    schedule=[MSHA_RAW],  # run when this asset is updated
    start_date=datetime(2026, 1, 1),
    catchup=False,
    max_active_runs=1,
    tags=["dbt", "transform"],
)
def dbt_build():

    @task.bash
    def dbt_build_all():
        # set -e stops at the first failing command; dbt build exits non-zero
        # if any model or error-severity test fails, which fails this task.
        return f"set -e; cd {DBT_DIR}; dbt build"

    @task.bash
    def dbt_docs():
        return f"set -e; cd {DBT_DIR}; dbt docs generate --static"

    @task(trigger_rule="all_success")
    def log_success():
        log_run("success", "dbt build and docs completed")

    @task(trigger_rule="one_failed")
    def log_failure():
        log_run("failed", "dbt build or docs failed. Check the task logs in Airflow")

    build = dbt_build_all()
    docs = dbt_docs()
    build >> docs >> [log_success(), log_failure()]


dbt_build()

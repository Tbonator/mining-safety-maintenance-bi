from datetime import datetime

from airflow.providers.postgres.hooks.postgres import PostgresHook
from airflow.sdk import dag, task

EXPECTED_SCHEMAS = ["raw", "staging", "intermediate", "marts", "etl"]


@dag(
    dag_id="check_warehouse",
    schedule=None,
    start_date=datetime(2026, 1, 1),
    catchup=False,
    tags=["setup"],
)
def check_warehouse():

    @task
    def check_schemas():
        hook = PostgresHook(postgres_conn_id="mining_dw")
        rows = hook.get_records(
            "SELECT schema_name FROM information_schema.schemata WHERE schema_name = ANY(%s)",
            parameters=(EXPECTED_SCHEMAS,),
        )
        found = sorted(r[0] for r in rows)
        missing = [s for s in EXPECTED_SCHEMAS if s not in found]
        if missing:
            raise ValueError(f"Missing schemas: {missing}")
        print(f"All schemas found: {found}")
        return found

    @task
    def log_run(schemas):
        hook = PostgresHook(postgres_conn_id="mining_dw")
        hook.run(
            "INSERT INTO etl.run_log (pipeline, status, message) VALUES (%s, %s, %s)",
            parameters=("check_warehouse", "success", f"Schemas found: {', '.join(schemas)}"),
        )
        print("Wrote a row to etl.run_log")

    log_run(check_schemas())


check_warehouse()
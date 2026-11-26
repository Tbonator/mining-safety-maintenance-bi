from datetime import datetime

from airflow.sdk import dag, task


@dag(
    dag_id="hello_mining",
    schedule=None,
    start_date=datetime(2026, 1, 1),
    catchup=False,
    tags=["learning"],
)
def hello_mining():

    @task
    def say_hello():
        print("Hello from my first Airflow task!")
        
        return "Thabo"

    @task
    def say_goodbye(name):
        print(f"Goodbye, {name}. The pipeline finished.")

    name = say_hello()
    say_goodbye(name)


hello_mining()
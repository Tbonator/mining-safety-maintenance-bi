"""
Shared Airflow assets.

An asset is a named piece of data. A task that updates it lists it in `outlets`;
a DAG that needs it lists it in `schedule`. Airflow then runs the second DAG
automatically whenever the first one has updated the data.
"""

from airflow.sdk import Asset

MSHA_RAW = Asset(name="msha_raw_tables")

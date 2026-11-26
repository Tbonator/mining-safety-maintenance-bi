# Start from the official Airflow image
FROM apache/airflow:3.4.0

# Copy our package list into the image
COPY requirements.txt /requirements.txt

# Install the packages, pinned to versions Airflow is tested with
RUN PYTHON_VERSION="$(python --version | cut -d ' ' -f 2 | cut -d '.' -f 1-2)" && \
    pip install --no-cache-dir \
      "apache-airflow==${AIRFLOW_VERSION}" \
      -r /requirements.txt \
      --constraint "https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt"
      
# dbt in its own virtual environment, so its packages can't clash with Airflow's
RUN python -m venv /opt/airflow/dbt_venv && \
    PIP_USER=false /opt/airflow/dbt_venv/bin/pip install --no-cache-dir \
      "dbt-core~=1.12.0" "dbt-postgres~=1.11.0"

# Make the dbt command available everywhere in the container
ENV PATH="${PATH}:/opt/airflow/dbt_venv/bin"
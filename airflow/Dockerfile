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
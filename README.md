# Mining Safety & Maintenance BI

An end-to-end data engineering and BI project on public US mine safety data (MSHA), built to learn and show a modern data stack.

## Stack
- PostgreSQL 16 in Docker (warehouse)
- Apache Airflow 3.4 (orchestration)
- dbt (transformations), coming soon
- Power BI and QlikView (dashboards), coming soon

## Run it
1. Copy `.env.example` to `.env` and set passwords (letters and numbers only)
2. `docker compose up -d`
3. Open Airflow at http://localhost:8080
4. Trigger the `check_warehouse` DAG

## Progress
- [x] Lesson 1: Git
- [x] Lesson 2: Docker
- [x] Lesson 3: Docker Compose and Postgres
- [x] Lesson 4: Airflow
- [ ] Step 2: MSHA ingestion
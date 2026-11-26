-- Runs once, on the first start of an empty database.

-- Medallion layers
CREATE SCHEMA raw;           -- bronze: data exactly as loaded
CREATE SCHEMA staging;       -- renamed and typed
CREATE SCHEMA intermediate;  -- silver: cleaned and conformed
CREATE SCHEMA marts;         -- gold: star schema for the dashboards
CREATE SCHEMA etl;           -- pipeline logs

-- One row per pipeline run, so we can see what ran and when
CREATE TABLE etl.run_log (
    run_id      BIGSERIAL PRIMARY KEY,
    pipeline    TEXT        NOT NULL,
    status      TEXT        NOT NULL,
    rows_loaded BIGINT,
    message     TEXT,
    logged_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- A separate database for Airflow's own bookkeeping (used in Lesson 4)
CREATE DATABASE airflow;
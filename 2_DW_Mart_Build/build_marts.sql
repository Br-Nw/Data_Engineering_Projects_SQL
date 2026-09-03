-- duckdb dw_marts.duckdb -c ".read build_marts.sql"  -- reads entire script

-- First step: Creating star schema tables
.read 01_create_tables_dw.sql

-- Second step: DW - Loading data from CSV files into relevant tables
.read 02_load_schema_dw.sql

-- Third step: Create flat mart table
.read 03_create_flat_mart.sql

-- Fourth step - Create skills demand mart
.read 04_create_skills_mart.sql

-- Fifth step: Mart - Create priority roles mart
.read 05_create_priority_mart.sql

-- Fifth step: Mart - Create priority roles mart
.read 06_update_priority_mart.sql
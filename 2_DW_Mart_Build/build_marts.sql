
-- First step: Creating star schema tables
.read 01_create_tables_dw.sql

-- Second step: DW - Loading data from CSV files into relevant tables
.read 02_load_schema_dw.sql
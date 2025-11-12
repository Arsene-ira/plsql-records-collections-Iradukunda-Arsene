# PL/SQL: Collections, Records, and GOTO — Examples
**Name**: Arsene Iradukunda
**Student ID**: 27206
*Course**: PL/SQL

This repository contains concise, runnable PL/SQL examples that demonstrate:
- **Collections**: associative arrays, nested tables, varrays
- **Records**: `%ROWTYPE` and custom `RECORD` types
- **GOTO**: a tiny demo (with warnings and alternatives)

Pre-reqs:
- Oracle DB (or Oracle XE) accessible.
- SQL*Plus / SQL Developer / SQLcl.

How to run:
1. Load schema (optional) `sql/00_schema_create.sql` — or use your existing schema (this repo assumes an `Employees` table exists; see your `pl codes.txt`). :contentReference[oaicite:2]{index=2}
2. Run the example scripts in order:
   - `@sql/01_collections_examples.sql`
   - `@sql/02_records_examples.sql`
   - `@sql/03_goto_example.sql`
3. Inspect results with `@sql/99_tests.sql`

# Design notes

- **Collections**:
  - Associative arrays: best for in-memory maps keyed by integer or string.
  - Nested tables: good for BULK COLLECT and passing to TABLE functions.
  - VARRAYs: fixed max size snapshots.

- **Records**:
  - `%ROWTYPE` binds to a table row and is handy for simple SELECT INTO.
  - Custom `RECORD` useful for aggregations and custom shaped data.

- **GOTO**:
  - Demonstration only. GOTO breaks structured flow; prefer EXIT/CONTINUE and well-structured code.
  - Use labeled blocks if you need to jump out of deeply nested logic, but refactor first.

- **How to run**:
  - Use SQL Developer or SQL*Plus and run each script in order.
  - If Employees table is not present, load `00_schema_create.sql` first (this repo assumes your provided schema exists). :contentReference[oaicite:5]{index=5}


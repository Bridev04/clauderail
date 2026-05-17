---
name: database-migrations
description: Use for schema design, migrations, query optimization, indexes, data backfills, and ORM changes.
---

# Database Migrations Skill

## Purpose
Make database changes safely and reversibly.

## Workflow
1. Identify database, ORM/migration tool, connection config, and existing migration conventions.
2. Separate schema migration from data backfill when risk is high.
3. Prefer additive migrations for zero/low downtime.
4. Avoid destructive changes until code no longer depends on old columns/tables.
5. Add indexes for new query patterns, but consider write overhead and lock behavior.
6. Validate constraints with existing data before enforcing them.
7. Write rollback notes even when down migrations are not supported.

## Checklist
- Migration generated or handwritten following repo convention.
- Models/schemas updated.
- Tests updated.
- Seed/demo data updated if needed.
- Performance checked for large tables.
- Backup/rollback risk documented.

## Output
- Schema change summary
- Migration safety assessment
- Query/index notes
- Validation commands
- Rollback plan

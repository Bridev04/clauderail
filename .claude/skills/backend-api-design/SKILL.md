---
name: backend-api-design
description: Use for backend APIs, services, auth, validation, rate limits, jobs, webhooks, and integration design.
---

# Backend API Design Skill

## Purpose
Design and implement safe, maintainable backend behavior.

## Workflow
1. Identify API framework, routing pattern, service layer, auth middleware, schema validation, database access, and error handling.
2. Keep controllers/routes thin; move business logic to services when the repo already follows that pattern.
3. Validate every request body, query param, path param, and uploaded file.
4. Enforce authorization and ownership server-side.
5. Add idempotency for webhooks, payments, long-running jobs, and external side effects.
6. Use safe error responses and structured logs without secrets.
7. Add tests for happy path, invalid input, unauthorized, forbidden, not found, and rate-limited behavior.

## API quality checklist
- Clear status codes
- Stable response shape
- Pagination/limits for lists
- Request size limits
- Rate limits for expensive endpoints
- Transaction boundaries for multi-step writes
- Observability for failures

## Output
- Design summary
- Files changed
- API contract
- Tests/checks
- Risks

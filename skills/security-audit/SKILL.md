---
name: security-audit
description: Use for security review, deployment readiness, auth checks, secret scanning, dependency risk, and abuse-case testing.
---

# Security Audit Skill

## Purpose
Find security and privacy risks before deployment.

## Checklist
- Secrets: no hardcoded keys, tokens, passwords, private URLs, cookies, auth headers, or credentials.
- Config: env vars loaded through centralized settings/config only; `.env.example` documented.
- Auth: protected routes require authentication and authorization; tenant/user ownership enforced server-side.
- Input: schema validation, sanitization, size limits, file upload restrictions.
- Abuse: rate limits on public, auth, upload, expensive, AI/LLM, and webhook endpoints.
- Data: avoid mass assignment; use allowlists; parameterized/ORM-safe queries only.
- Errors: no stack traces, SQL, internal paths, secrets, or private content leaked to clients.
- Logging: security events logged without private content or tokens.
- Dependencies: known vulnerable packages and abandoned libraries flagged.
- AI-specific: prompt injection boundaries, tool permission restrictions, output validation, data retention notes.

## Validation commands to consider
- Secret scan: `gitleaks detect`, `trufflehog filesystem .`, or equivalent.
- Dependencies: `npm audit`, `pnpm audit`, `pip-audit`, `safety`, `cargo audit`, `osv-scanner`.
- SAST: project-appropriate static analysis.
- Tests: unauthorized, invalid input, rate-limit, and abuse tests.

## Output
- Critical blockers
- High-priority risks
- Medium improvements
- Tests to add
- Deployment decision

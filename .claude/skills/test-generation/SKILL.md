---
name: test-generation
description: Use when adding or improving unit, integration, e2e, regression, security, or AI evaluation tests.
---

# Test Generation Skill

## Purpose
Add high-signal tests that protect real behavior.

## Workflow
1. Identify the behavior contract from code, routes, schemas, UI, docs, or user request.
2. Locate existing test framework, helpers, fixtures, factories, and naming conventions.
3. Add the smallest useful tests first: regression test for bug, happy path, boundary cases, and failure path.
4. For APIs, test invalid input, unauthorized access, ownership checks, rate limits, and error shape.
5. For UI, test user-visible behavior and accessibility basics rather than implementation details.
6. For AI/LLM features, use fake clients and deterministic fixtures; do not call paid APIs in normal tests.
7. Run the relevant test file and fix failures.

## Anti-patterns
- Do not snapshot huge unstable output.
- Do not test private implementation details when public behavior is enough.
- Do not add flaky timing-based tests.
- Do not require network access unless explicitly marked integration/e2e.

## Output
- Test coverage added
- Commands run
- Gaps remaining

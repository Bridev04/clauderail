---
name: performance-profiling
description: Use for slow pages, APIs, builds, tests, database queries, memory issues, bundle size, or load testing.
---

# Performance Profiling Skill

## Purpose
Improve performance using measurements, not guesses.

## Workflow
1. Define the performance target: latency, throughput, memory, bundle size, build time, test time, query time, or UX metric.
2. Reproduce the slow path and collect baseline measurements.
3. Identify the bottleneck with profiling/logging/tracing/query plans before changing code.
4. Apply the smallest optimization.
5. Re-measure and compare with baseline.
6. Add regression checks where practical.

## Areas to inspect
- N+1 queries
- Missing indexes
- Unbounded list queries
- Large client bundles
- Excessive re-renders
- Blocking network waterfalls
- Synchronous CPU work on request path
- Cache misuse/staleness
- Test suite bottlenecks

## Output
- Baseline
- Bottleneck evidence
- Change made
- After measurement
- Tradeoffs and remaining risks

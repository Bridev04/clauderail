---
name: ai-llm-rag-evals
description: Use for LLM apps, RAG, agents, prompt chains, tool calling, evals, safety boundaries, and deterministic AI tests.
---

# AI, LLM, RAG, and Evals Skill

## Purpose
Build AI features that are testable, observable, safe, and useful beyond a simple API wrapper.

## Workflow
1. Identify user task, model provider, model config, prompt boundaries, tools, retrieval sources, and output schema.
2. Separate provider clients from product logic behind an interface.
3. Centralize model name, API keys, timeouts, max tokens, and retry policy in config.
4. Use structured outputs or schemas when downstream code depends on format.
5. Add deterministic tests with fake LLM clients.
6. Add eval datasets for quality-critical behavior.
7. For RAG, evaluate chunking, metadata, retrieval quality, citations, and answer grounding.
8. For agents, restrict tools, validate tool inputs/outputs, and log decisions without private content.

## Safety checklist
- Prompt injection boundaries documented.
- User data retention implications considered.
- No secrets in prompts/logs.
- Rate limits and cost controls on AI endpoints.
- Fallback behavior for provider errors/timeouts.

## Output
- Architecture summary
- Prompt/tool/schema design
- Eval plan
- Safety risks
- Tests/checks

---
description: Explain what code does, how a feature works, or why a piece of the system is the way it is. Read-only.
allowed-tools: Read, Grep, Glob, LS, Bash
argument-hint: "<file, function, concept, or question>"
---

# /explain

## Task

`$ARGUMENTS` is what to explain. If empty, ask what the user wants explained and stop.

This is a read-only command. Do not edit files. Do not propose changes.

### Method

1. **Find the actual code.** Don't explain based on what you assume the code does — read it.
   - If `$ARGUMENTS` is a file path, read that file.
   - If `$ARGUMENTS` is a function/class name, grep for the definition.
   - If `$ARGUMENTS` is a concept ("how does auth work here"), find the entrypoints and follow the call graph.

2. **Trace the data flow.** For "how does X work" questions, walk the path from input to output through the actual code. Cite file:line for each step.

3. **Explain at the right altitude.**
   - If the user asked about a function, explain the function, not the entire system.
   - If the user asked "how does login work", give the system-level walk-through and mention which file holds each piece, but don't paste the whole code.

4. **Distinguish "what the code does" from "why it was done that way".**
   - "What" you can read from the source.
   - "Why" usually requires looking at commit history (`git log -p <file>`), comments, ADRs, or README context. If you can't find a "why", say so — don't invent one.

### Output

Match the question. For a function: a 3-6 sentence explanation plus the call sites. For a system: a short walk-through with file:line citations. For a "why" question: cite the source of the rationale (commit message, ADR, comment, or "I couldn't find a documented reason").

Code snippets are fine but keep them small — show the relevant lines, not the whole file. Always cite file paths so the user can read the surrounding context themselves.

### Rules

- Never paraphrase code you didn't actually read.
- If two parts of the codebase seem to do similar things, note both and which one is authoritative if you can tell.
- If the explanation reveals a bug or confusion, surface it at the end as "While reading this I noticed..." — but don't pivot to fixing it.

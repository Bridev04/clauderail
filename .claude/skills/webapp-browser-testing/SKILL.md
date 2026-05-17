---
name: webapp-browser-testing
description: Use for Playwright/Puppeteer browser verification, UI smoke tests, console error checks, and end-to-end web flows.
---

# Webapp Browser Testing Skill

## Purpose
Verify real browser behavior beyond unit tests.

## Workflow
1. Start the app using discovered commands.
2. Use the correct local URL and port from terminal output.
3. Test critical routes: home, auth pages, dashboard, create/edit flows, settings, error/empty states.
4. Check browser console, network errors, hydration warnings, and failed API calls.
5. Test keyboard navigation and mobile viewport for core flows.
6. Capture screenshots only when helpful for review.

## Common failures to catch
- Port mismatch
- Hydration errors
- Broken asset paths
- API base URL mismatch
- CORS/session cookie issues
- Form submission silently failing
- Missing loading/error states

## Output
- Routes tested
- Browser findings
- Console/network errors
- Screenshots if captured
- Fixes or next actions

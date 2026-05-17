# Security Rules

Apply these rules to all code, architecture, docs, and reviews.

- Deny-by-default access control.
- Never trust client-side validation.
- Avoid dynamic shell execution. If unavoidable, use allowlists and safe argument arrays.
- Avoid raw SQL. If unavoidable, parameterize every value.
- Store secrets only in environment/secret managers.
- Never print secrets.
- Validate files by MIME, extension, size, and content where possible.
- Use CSRF protection for cookie-based auth.
- Use secure cookie attributes: HttpOnly, Secure, SameSite.
- Add structured logs for auth failures, permission denials, rate limits, and sensitive changes.

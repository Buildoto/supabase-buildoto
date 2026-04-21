# supabase-buildoto

Self-hosted Supabase template deployed on Coolify as the backend for
[Buildoto](https://github.com/buildoto/buildoto).

Forked from [SebWell/supabase-coolify](https://github.com/SebWell/supabase-coolify) —
upstream provides a ready-to-deploy docker-compose stack (Postgres, Auth, Kong,
PostgREST, Realtime, Storage, Studio, Supavisor, Edge Functions, Analytics).

## Buildoto-specific adaptations

### 1. Analytics is non-blocking

Upstream declares `depends_on: supabase-analytics: { condition: service_healthy }`
on 9 services (Kong, Studio, Auth, REST, Realtime, Storage, Meta, Edge Functions,
Supavisor). If Logflare crashes or is slow to become healthy, the entire stack
fails to start.

This fork switches every `service_healthy` on `supabase-analytics` to
`service_started` so a Logflare hiccup doesn't take down the core DB + Auth +
API path. Trade-off: Studio's "Logs" tab may show errors briefly when analytics
is unhealthy; the rest of Supabase keeps working.

## Deploy on Coolify

1. New resource → Docker Compose → **Public Repository** → `https://github.com/buildoto/supabase-buildoto`
2. Branch `main`
3. Set the env vars (see upstream docs for the full list — secrets should be
   regenerated, never use the default placeholders in production)
4. Domain: point `SERVICE_FQDN_SUPABASE_KONG` at your public hostname
5. Deploy

## Syncing upstream fixes

```bash
git remote add upstream https://github.com/SebWell/supabase-coolify.git
git fetch upstream
git merge upstream/main   # review, resolve conflicts (the analytics change
                          # will likely conflict — keep ours: service_started)
```

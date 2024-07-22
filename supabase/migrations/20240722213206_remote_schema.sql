drop policy "Restrict read access for all users" on "public"."donors";

alter table "public"."donors" add column "created_at" date not null default now();

alter table "public"."donors" add column "message" text;

create policy "Restrict select to anon"
on "public"."donors"
as restrictive
for select
to anon
using (true);


create policy "TTL 1 min - select"
on "public"."donors"
as permissive
for select
to anon
using ((created_at > (CURRENT_TIMESTAMP - '00:01:00'::interval)));




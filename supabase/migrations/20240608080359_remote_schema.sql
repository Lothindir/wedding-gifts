create policy "TEMP dev 1ffg0oo_0"
on "storage"."objects"
as permissive
for select
to public
using ((bucket_id = 'images'::text));


create policy "TEMP dev 1ffg0oo_1"
on "storage"."objects"
as permissive
for insert
to public
with check ((bucket_id = 'images'::text));


create policy "Upload and download access to authenticated users 1ffg0oo_0"
on "storage"."objects"
as permissive
for select
to public
using (((bucket_id = 'images'::text) AND ((storage.extension(name) = 'jpg'::text) OR (storage.extension(name) = 'jpeg'::text) OR (storage.extension(name) = 'png'::text) OR (storage.extension(name) = 'gif'::text) OR (storage.extension(name) = 'webp'::text)) AND (lower((storage.foldername(name))[1]) = 'public'::text)));


create policy "Upload and download access to authenticated users 1ffg0oo_1"
on "storage"."objects"
as permissive
for insert
to public
with check (((bucket_id = 'images'::text) AND ((storage.extension(name) = 'jpg'::text) OR (storage.extension(name) = 'jpeg'::text) OR (storage.extension(name) = 'png'::text) OR (storage.extension(name) = 'gif'::text) OR (storage.extension(name) = 'webp'::text)) AND (lower((storage.foldername(name))[1]) = 'public'::text)));





SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

CREATE SCHEMA IF NOT EXISTS "public";

ALTER SCHEMA "public" OWNER TO "pg_database_owner";

COMMENT ON SCHEMA "public" IS 'standard public schema';

CREATE SCHEMA IF NOT EXISTS "storage";

ALTER SCHEMA "storage" OWNER TO "supabase_admin";

CREATE OR REPLACE FUNCTION "storage"."can_insert_object"("bucketid" "text", "name" "text", "owner" "uuid", "metadata" "jsonb") RETURNS "void"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;

ALTER FUNCTION "storage"."can_insert_object"("bucketid" "text", "name" "text", "owner" "uuid", "metadata" "jsonb") OWNER TO "supabase_storage_admin";

CREATE OR REPLACE FUNCTION "storage"."extension"("name" "text") RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;

ALTER FUNCTION "storage"."extension"("name" "text") OWNER TO "supabase_storage_admin";

CREATE OR REPLACE FUNCTION "storage"."filename"("name" "text") RETURNS "text"
    LANGUAGE "plpgsql"
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;

ALTER FUNCTION "storage"."filename"("name" "text") OWNER TO "supabase_storage_admin";

CREATE OR REPLACE FUNCTION "storage"."foldername"("name" "text") RETURNS "text"[]
    LANGUAGE "plpgsql"
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;

ALTER FUNCTION "storage"."foldername"("name" "text") OWNER TO "supabase_storage_admin";

CREATE OR REPLACE FUNCTION "storage"."get_size_by_bucket"() RETURNS TABLE("size" bigint, "bucket_id" "text")
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;

ALTER FUNCTION "storage"."get_size_by_bucket"() OWNER TO "supabase_storage_admin";

CREATE OR REPLACE FUNCTION "storage"."list_multipart_uploads_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer DEFAULT 100, "next_key_token" "text" DEFAULT ''::"text", "next_upload_token" "text" DEFAULT ''::"text") RETURNS TABLE("key" "text", "id" "text", "created_at" timestamp with time zone)
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;

ALTER FUNCTION "storage"."list_multipart_uploads_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer, "next_key_token" "text", "next_upload_token" "text") OWNER TO "supabase_storage_admin";

CREATE OR REPLACE FUNCTION "storage"."list_objects_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer DEFAULT 100, "start_after" "text" DEFAULT ''::"text", "next_token" "text" DEFAULT ''::"text") RETURNS TABLE("name" "text", "id" "uuid", "metadata" "jsonb", "updated_at" timestamp with time zone)
    LANGUAGE "plpgsql"
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;

ALTER FUNCTION "storage"."list_objects_with_delimiter"("bucket_id" "text", "prefix_param" "text", "delimiter_param" "text", "max_keys" integer, "start_after" "text", "next_token" "text") OWNER TO "supabase_storage_admin";

CREATE OR REPLACE FUNCTION "storage"."operation"() RETURNS "text"
    LANGUAGE "plpgsql" STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;

ALTER FUNCTION "storage"."operation"() OWNER TO "supabase_storage_admin";

CREATE OR REPLACE FUNCTION "storage"."search"("prefix" "text", "bucketname" "text", "limits" integer DEFAULT 100, "levels" integer DEFAULT 1, "offsets" integer DEFAULT 0, "search" "text" DEFAULT ''::"text", "sortcolumn" "text" DEFAULT 'name'::"text", "sortorder" "text" DEFAULT 'asc'::"text") RETURNS TABLE("name" "text", "id" "uuid", "updated_at" timestamp with time zone, "created_at" timestamp with time zone, "last_accessed_at" timestamp with time zone, "metadata" "jsonb")
    LANGUAGE "plpgsql" STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;

ALTER FUNCTION "storage"."search"("prefix" "text", "bucketname" "text", "limits" integer, "levels" integer, "offsets" integer, "search" "text", "sortcolumn" "text", "sortorder" "text") OWNER TO "supabase_storage_admin";

CREATE OR REPLACE FUNCTION "storage"."update_updated_at_column"() RETURNS "trigger"
    LANGUAGE "plpgsql"
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;

ALTER FUNCTION "storage"."update_updated_at_column"() OWNER TO "supabase_storage_admin";

SET default_tablespace = '';

SET default_table_access_method = "heap";

CREATE TABLE IF NOT EXISTS "public"."gift_translations" (
    "id" bigint NOT NULL,
    "language" "text" NOT NULL,
    "title" "text" NOT NULL,
    "description" "text" DEFAULT ''::"text" NOT NULL,
    "gift" bigint NOT NULL
);

ALTER TABLE "public"."gift_translations" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."gifts" (
    "id" bigint NOT NULL,
    "price" real NOT NULL,
    "parts" integer DEFAULT 0 NOT NULL,
    "image" "text" DEFAULT ''::"text" NOT NULL,
    "hidden" boolean DEFAULT false NOT NULL
);

ALTER TABLE "public"."gifts" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."transactions" (
    "id" bigint NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "amount" real NOT NULL,
    "gift" bigint NOT NULL,
    "donor" bigint NOT NULL
);

ALTER TABLE "public"."transactions" OWNER TO "postgres";

CREATE OR REPLACE VIEW "public"."all_gifts" WITH ("security_invoker"='on') AS
 SELECT "gifts"."id",
    "gifts"."price",
    "gifts"."parts",
    "gifts"."image",
    "gift_translations"."title",
    "gift_translations"."description",
    "gift_translations"."language",
    "sum"("transactions"."amount") AS "amount_gifted"
   FROM (("public"."gifts"
     LEFT JOIN "public"."gift_translations" ON (("gifts"."id" = "gift_translations"."gift")))
     LEFT JOIN "public"."transactions" ON (("gifts"."id" = "transactions"."gift")))
  GROUP BY "gifts"."id", "gifts"."price", "gifts"."parts", "gifts"."image", "gift_translations"."title", "gift_translations"."description", "gift_translations"."language";

ALTER TABLE "public"."all_gifts" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."donors" (
    "id" bigint NOT NULL,
    "name" "text" NOT NULL,
    "surname" "text" NOT NULL,
    "address" "text" DEFAULT ''::"text" NOT NULL,
    "email" "text" DEFAULT ''::"text" NOT NULL
);

ALTER TABLE "public"."donors" OWNER TO "postgres";

ALTER TABLE "public"."donors" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."donors_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE "public"."gift_translations" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."gift_translations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE "public"."gifts" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."gifts_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE OR REPLACE VIEW "public"."gifts_visible" WITH ("security_invoker"='on') AS
 SELECT "gifts"."id",
    "gifts"."price",
    "gifts"."parts",
    "gifts"."image",
    "gift_translations"."title",
    "gift_translations"."description",
    "gift_translations"."language",
    "sum"("transactions"."amount") AS "amount_gifted"
   FROM (("public"."gifts"
     JOIN "public"."gift_translations" ON (("gifts"."id" = "gift_translations"."gift")))
     LEFT JOIN "public"."transactions" ON (("gifts"."id" = "transactions"."gift")))
  WHERE ("gifts"."hidden" = false)
  GROUP BY "gifts"."id", "gifts"."price", "gifts"."parts", "gifts"."image", "gift_translations"."title", "gift_translations"."description", "gift_translations"."language";

ALTER TABLE "public"."gifts_visible" OWNER TO "postgres";

CREATE TABLE IF NOT EXISTS "public"."settings" (
    "id" bigint NOT NULL,
    "key" "text" NOT NULL,
    "value" "text" NOT NULL
);

ALTER TABLE "public"."settings" OWNER TO "postgres";

ALTER TABLE "public"."settings" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."settings_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

ALTER TABLE "public"."transactions" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."transactions_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE IF NOT EXISTS "storage"."buckets" (
    "id" "text" NOT NULL,
    "name" "text" NOT NULL,
    "owner" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "public" boolean DEFAULT false,
    "avif_autodetection" boolean DEFAULT false,
    "file_size_limit" bigint,
    "allowed_mime_types" "text"[],
    "owner_id" "text"
);

ALTER TABLE "storage"."buckets" OWNER TO "supabase_storage_admin";

COMMENT ON COLUMN "storage"."buckets"."owner" IS 'Field is deprecated, use owner_id instead';

CREATE TABLE IF NOT EXISTS "storage"."migrations" (
    "id" integer NOT NULL,
    "name" character varying(100) NOT NULL,
    "hash" character varying(40) NOT NULL,
    "executed_at" timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);

ALTER TABLE "storage"."migrations" OWNER TO "supabase_storage_admin";

CREATE TABLE IF NOT EXISTS "storage"."objects" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "bucket_id" "text",
    "name" "text",
    "owner" "uuid",
    "created_at" timestamp with time zone DEFAULT "now"(),
    "updated_at" timestamp with time zone DEFAULT "now"(),
    "last_accessed_at" timestamp with time zone DEFAULT "now"(),
    "metadata" "jsonb",
    "path_tokens" "text"[] GENERATED ALWAYS AS ("string_to_array"("name", '/'::"text")) STORED,
    "version" "text",
    "owner_id" "text"
);

ALTER TABLE "storage"."objects" OWNER TO "supabase_storage_admin";

COMMENT ON COLUMN "storage"."objects"."owner" IS 'Field is deprecated, use owner_id instead';

CREATE TABLE IF NOT EXISTS "storage"."s3_multipart_uploads" (
    "id" "text" NOT NULL,
    "in_progress_size" bigint DEFAULT 0 NOT NULL,
    "upload_signature" "text" NOT NULL,
    "bucket_id" "text" NOT NULL,
    "key" "text" NOT NULL COLLATE "pg_catalog"."C",
    "version" "text" NOT NULL,
    "owner_id" "text",
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);

ALTER TABLE "storage"."s3_multipart_uploads" OWNER TO "supabase_storage_admin";

CREATE TABLE IF NOT EXISTS "storage"."s3_multipart_uploads_parts" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "upload_id" "text" NOT NULL,
    "size" bigint DEFAULT 0 NOT NULL,
    "part_number" integer NOT NULL,
    "bucket_id" "text" NOT NULL,
    "key" "text" NOT NULL COLLATE "pg_catalog"."C",
    "etag" "text" NOT NULL,
    "owner_id" "text",
    "version" "text" NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL
);

ALTER TABLE "storage"."s3_multipart_uploads_parts" OWNER TO "supabase_storage_admin";

ALTER TABLE ONLY "public"."donors"
    ADD CONSTRAINT "donors_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."gift_translations"
    ADD CONSTRAINT "gift_translations_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."gifts"
    ADD CONSTRAINT "gifts_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."settings"
    ADD CONSTRAINT "settings_key_key" UNIQUE ("key");

ALTER TABLE ONLY "public"."settings"
    ADD CONSTRAINT "settings_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "storage"."buckets"
    ADD CONSTRAINT "buckets_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "storage"."migrations"
    ADD CONSTRAINT "migrations_name_key" UNIQUE ("name");

ALTER TABLE ONLY "storage"."migrations"
    ADD CONSTRAINT "migrations_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "storage"."objects"
    ADD CONSTRAINT "objects_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "storage"."s3_multipart_uploads_parts"
    ADD CONSTRAINT "s3_multipart_uploads_parts_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "storage"."s3_multipart_uploads"
    ADD CONSTRAINT "s3_multipart_uploads_pkey" PRIMARY KEY ("id");

CREATE UNIQUE INDEX "bname" ON "storage"."buckets" USING "btree" ("name");

CREATE UNIQUE INDEX "bucketid_objname" ON "storage"."objects" USING "btree" ("bucket_id", "name");

CREATE INDEX "idx_multipart_uploads_list" ON "storage"."s3_multipart_uploads" USING "btree" ("bucket_id", "key", "created_at");

CREATE INDEX "idx_objects_bucket_id_name" ON "storage"."objects" USING "btree" ("bucket_id", "name" COLLATE "C");

CREATE INDEX "name_prefix_search" ON "storage"."objects" USING "btree" ("name" "text_pattern_ops");

CREATE OR REPLACE TRIGGER "update_objects_updated_at" BEFORE UPDATE ON "storage"."objects" FOR EACH ROW EXECUTE FUNCTION "storage"."update_updated_at_column"();

ALTER TABLE ONLY "public"."gift_translations"
    ADD CONSTRAINT "gift_translations_gift_fkey" FOREIGN KEY ("gift") REFERENCES "public"."gifts"("id") ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_donor_fkey" FOREIGN KEY ("donor") REFERENCES "public"."donors"("id") ON UPDATE CASCADE;

ALTER TABLE ONLY "public"."transactions"
    ADD CONSTRAINT "transactions_gift_fkey" FOREIGN KEY ("gift") REFERENCES "public"."gifts"("id") ON UPDATE CASCADE;

ALTER TABLE ONLY "storage"."objects"
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets"("id");

ALTER TABLE ONLY "storage"."s3_multipart_uploads"
    ADD CONSTRAINT "s3_multipart_uploads_bucket_id_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets"("id");

ALTER TABLE ONLY "storage"."s3_multipart_uploads_parts"
    ADD CONSTRAINT "s3_multipart_uploads_parts_bucket_id_fkey" FOREIGN KEY ("bucket_id") REFERENCES "storage"."buckets"("id");

ALTER TABLE ONLY "storage"."s3_multipart_uploads_parts"
    ADD CONSTRAINT "s3_multipart_uploads_parts_upload_id_fkey" FOREIGN KEY ("upload_id") REFERENCES "storage"."s3_multipart_uploads"("id") ON DELETE CASCADE;

CREATE POLICY "Enable insert for authenticated users only" ON "public"."donors" FOR INSERT TO "anon" WITH CHECK (true);

CREATE POLICY "Enable read access for all users" ON "public"."gift_translations" FOR SELECT USING (true);

CREATE POLICY "Enable read access for all users" ON "public"."gifts" FOR SELECT USING (true);

CREATE POLICY "Enable read access for all users" ON "public"."settings" FOR SELECT USING (true);

CREATE POLICY "Enable read access for all users" ON "public"."transactions" FOR SELECT USING (true);

CREATE POLICY "Restrict read access for all users" ON "public"."donors" AS RESTRICTIVE FOR SELECT TO "anon" USING (true);

CREATE POLICY "TEMP dev permissions" ON "public"."gift_translations" USING (true);

CREATE POLICY "TEMP dev permissions" ON "public"."gifts" USING (true);

ALTER TABLE "public"."donors" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."gift_translations" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."gifts" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."settings" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "public"."transactions" ENABLE ROW LEVEL SECURITY;

CREATE POLICY "TEMP dev 1ffg0oo_0" ON "storage"."objects" FOR SELECT USING (("bucket_id" = 'images'::"text"));

CREATE POLICY "TEMP dev 1ffg0oo_1" ON "storage"."objects" FOR INSERT WITH CHECK (("bucket_id" = 'images'::"text"));

CREATE POLICY "Upload and download access to authenticated users 1ffg0oo_0" ON "storage"."objects" FOR SELECT USING ((("bucket_id" = 'images'::"text") AND (("storage"."extension"("name") = 'jpg'::"text") OR ("storage"."extension"("name") = 'jpeg'::"text") OR ("storage"."extension"("name") = 'png'::"text") OR ("storage"."extension"("name") = 'gif'::"text") OR ("storage"."extension"("name") = 'webp'::"text")) AND ("lower"(("storage"."foldername"("name"))[1]) = 'public'::"text")));

CREATE POLICY "Upload and download access to authenticated users 1ffg0oo_1" ON "storage"."objects" FOR INSERT WITH CHECK ((("bucket_id" = 'images'::"text") AND (("storage"."extension"("name") = 'jpg'::"text") OR ("storage"."extension"("name") = 'jpeg'::"text") OR ("storage"."extension"("name") = 'png'::"text") OR ("storage"."extension"("name") = 'gif'::"text") OR ("storage"."extension"("name") = 'webp'::"text")) AND ("lower"(("storage"."foldername"("name"))[1]) = 'public'::"text")));

ALTER TABLE "storage"."buckets" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "storage"."migrations" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "storage"."objects" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "storage"."s3_multipart_uploads" ENABLE ROW LEVEL SECURITY;

ALTER TABLE "storage"."s3_multipart_uploads_parts" ENABLE ROW LEVEL SECURITY;

GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";

GRANT ALL ON SCHEMA "storage" TO "postgres";
GRANT USAGE ON SCHEMA "storage" TO "anon";
GRANT USAGE ON SCHEMA "storage" TO "authenticated";
GRANT USAGE ON SCHEMA "storage" TO "service_role";
GRANT ALL ON SCHEMA "storage" TO "supabase_storage_admin";
GRANT ALL ON SCHEMA "storage" TO "dashboard_user";

GRANT ALL ON TABLE "public"."gift_translations" TO "anon";
GRANT ALL ON TABLE "public"."gift_translations" TO "authenticated";
GRANT ALL ON TABLE "public"."gift_translations" TO "service_role";

GRANT ALL ON TABLE "public"."gifts" TO "anon";
GRANT ALL ON TABLE "public"."gifts" TO "authenticated";
GRANT ALL ON TABLE "public"."gifts" TO "service_role";

GRANT ALL ON TABLE "public"."transactions" TO "anon";
GRANT ALL ON TABLE "public"."transactions" TO "authenticated";
GRANT ALL ON TABLE "public"."transactions" TO "service_role";

GRANT ALL ON TABLE "public"."all_gifts" TO "anon";
GRANT ALL ON TABLE "public"."all_gifts" TO "authenticated";
GRANT ALL ON TABLE "public"."all_gifts" TO "service_role";

GRANT ALL ON TABLE "public"."donors" TO "anon";
GRANT ALL ON TABLE "public"."donors" TO "authenticated";
GRANT ALL ON TABLE "public"."donors" TO "service_role";

GRANT ALL ON SEQUENCE "public"."donors_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."donors_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."donors_id_seq" TO "service_role";

GRANT ALL ON SEQUENCE "public"."gift_translations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."gift_translations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."gift_translations_id_seq" TO "service_role";

GRANT ALL ON SEQUENCE "public"."gifts_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."gifts_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."gifts_id_seq" TO "service_role";

GRANT ALL ON TABLE "public"."gifts_visible" TO "anon";
GRANT ALL ON TABLE "public"."gifts_visible" TO "authenticated";
GRANT ALL ON TABLE "public"."gifts_visible" TO "service_role";

GRANT ALL ON TABLE "public"."settings" TO "anon";
GRANT ALL ON TABLE "public"."settings" TO "authenticated";
GRANT ALL ON TABLE "public"."settings" TO "service_role";

GRANT ALL ON SEQUENCE "public"."settings_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."settings_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."settings_id_seq" TO "service_role";

GRANT ALL ON SEQUENCE "public"."transactions_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."transactions_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."transactions_id_seq" TO "service_role";

GRANT ALL ON TABLE "storage"."buckets" TO "anon";
GRANT ALL ON TABLE "storage"."buckets" TO "authenticated";
GRANT ALL ON TABLE "storage"."buckets" TO "service_role";
GRANT ALL ON TABLE "storage"."buckets" TO "postgres";

GRANT ALL ON TABLE "storage"."migrations" TO "anon";
GRANT ALL ON TABLE "storage"."migrations" TO "authenticated";
GRANT ALL ON TABLE "storage"."migrations" TO "service_role";
GRANT ALL ON TABLE "storage"."migrations" TO "postgres";

GRANT ALL ON TABLE "storage"."objects" TO "anon";
GRANT ALL ON TABLE "storage"."objects" TO "authenticated";
GRANT ALL ON TABLE "storage"."objects" TO "service_role";
GRANT ALL ON TABLE "storage"."objects" TO "postgres";

GRANT ALL ON TABLE "storage"."s3_multipart_uploads" TO "service_role";
GRANT SELECT ON TABLE "storage"."s3_multipart_uploads" TO "authenticated";
GRANT SELECT ON TABLE "storage"."s3_multipart_uploads" TO "anon";

GRANT ALL ON TABLE "storage"."s3_multipart_uploads_parts" TO "service_role";
GRANT SELECT ON TABLE "storage"."s3_multipart_uploads_parts" TO "authenticated";
GRANT SELECT ON TABLE "storage"."s3_multipart_uploads_parts" TO "anon";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON SEQUENCES  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON FUNCTIONS  TO "service_role";

ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "storage" GRANT ALL ON TABLES  TO "service_role";

RESET ALL;

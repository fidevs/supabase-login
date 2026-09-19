CREATE TABLE IF NOT EXISTS "public"."profiles" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "created_at" timestamp with time zone DEFAULT "now"() NOT NULL,
    "full_name" "text" NOT NULL
);

COMMENT ON TABLE "public"."profiles" IS 'User profile';

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_pkey" PRIMARY KEY ("id");

ALTER TABLE ONLY "public"."profiles"
    ADD CONSTRAINT "profiles_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id") ON UPDATE CASCADE ON DELETE SET NULL;

CREATE POLICY "Enable users to view their own data only"
    ON "public"."profiles"
    FOR SELECT
    TO "authenticated" 
    USING ((( SELECT "auth"."uid"() AS "uid") = "id"));

ALTER TABLE "public"."profiles" ENABLE ROW LEVEL SECURITY;

-- Create "cities" table
CREATE TABLE "public"."cities" (
  "id" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  "updated_at" timestamptz NOT NULL,
  "is_active" boolean NULL DEFAULT true,
  "name" character varying(100) NOT NULL,
  PRIMARY KEY ("id")
);

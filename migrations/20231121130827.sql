-- Modify "cities" table
ALTER TABLE "public"."cities" ADD COLUMN "status" text NULL;
-- Modify "friends" table
ALTER TABLE "public"."friends" ADD COLUMN "active" boolean NULL;

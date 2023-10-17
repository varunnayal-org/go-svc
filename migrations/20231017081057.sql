-- Create enum type "city_category_enum"
CREATE TYPE "public"."city_category_enum" AS ENUM ('Twin', 'Mega', 'Garden');
-- Modify "cities" table
ALTER TABLE "public"."cities" ADD COLUMN "category" "public"."city_category_enum" NOT NULL;

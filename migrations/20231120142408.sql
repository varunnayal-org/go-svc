-- Create index "idx_user_id_friend_id" to table: "friends"
CREATE UNIQUE INDEX "idx_user_id_friend_id" ON "public"."friends" ("user_id", "friend_id");

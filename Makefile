migrate-generate:
	atlas migrate diff --env gorm

migrate-generate-hash:
	atlas migrate hash --env gorm

migrate-new:
	if [ -z "$(desc)" ]; then echo "Pass args desc={description}"; exit 1; fi
	$(eval dir := $(shell if [ -z "$(d)" ]; then echo ""; else echo "/$(d)"; fi))
	atlas migrate new --edit --dir file://${MIGRATION_DIR}${dir} $(desc)

migrate-hash:
	$(eval dir := $(shell if [ -z "$(d)" ]; then echo ""; else echo "/$(d)"; fi))
	atlas migrate hash --dir file://${MIGRATION_DIR}${dir}
migrate-lint:
	$(eval dir := $(shell if [ -z "$(d)" ]; then echo ""; else echo "/$(d)"; fi))
	$(eval latest := $(shell if [ -z "$(l)" ]; then echo ""; else echo "$(l)"; fi))
	atlas migrate lint --dev-url "${DEV_DB}" --dir file://${MIGRATION_DIR}${dir} --latest ${latest}
	#  -c file://${ATLAS_FILE}
migrate-lintjson:
	$(eval dir := $(shell if [ -z "$(d)" ]; then echo ""; else echo "/$(d)"; fi))
	$(eval latest := $(shell if [ -z "$(l)" ]; then echo ""; else echo "$(l)"; fi))
	atlas migrate lint --dev-url "${DEV_DB}" --dir file://${MIGRATION_DIR}${dir} --format '{{ json .Files }}' --latest ${latest} | jq


migrate-apply:
	$(eval dir := $(shell if [ -z "$(d)" ]; then echo ""; else echo "/$(d)"; fi))
	# echo atlas migrate apply --baseline 00000000000000 --dir file://${MIGRATION_DIR}${dir} --revisions-schema public --url "${DB_CONN_URL}" $(ARGS)
	atlas migrate apply --dir file://${MIGRATION_DIR}${dir} --revisions-schema public --url "${DB_CONN_URL}" $(ARGS)
migrate-dry:
	make migrate-apply ARGS="--dry-run" d=$(d)
migrate-generate:
	atlas migrate diff --env gorm

migrate-generate-hash:
	atlas migrate hash --env gorm

migrate-new:
	if [ -z "$(desc)" ]; then echo "Pass args desc={description}"; exit 1; fi
	atlas-local migrate new --edit --dir file://${MIGRATION_DIR} $(desc) && make migrate-hash

migrate-hash:
	atlas-local migrate hash --dir file://${MIGRATION_DIR}
migrate-lint:
	atlas-local migrate lint --dev-url "${DEV_DB}" --dir file://${MIGRATION_DIR} -c file://${ATLAS_FILE}
migrate-lintjson:
	atlas-local migrate lint --dev-url "${DEV_DB}" --dir file://${MIGRATION_DIR} -c file://atlas.hcl --format '{{ json .Files }}' | jq

migrate-apply:
	atlas-local migrate apply --baseline 00000000000000 --dir file://${MIGRATION_DIR} --revisions-schema public --url "${DB_CONN_URL}" $(ARGS)
migrate-dry:
	make migrate-apply ARGS="--dry-run"
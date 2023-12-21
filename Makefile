migrate-generate:
	atlas migrate diff --env gorm

migrate-generate-hash:
	atlas migrate hash --env gorm

migrate-new:
	# if [ -z "$1" ]; then echo "env is empty"; exit 1; fi
	if [ -z "$1" ]; then echo "name is empty"; exit 1; fi
	atlas migrate new --dir file://migrations $1
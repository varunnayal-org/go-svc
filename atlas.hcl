data "external_schema" "gorm" {
  program = [
    "go",
    "run",
    "-mod=mod",
    "./migration-loader",
  ]
}

env "gorm" {
  src = data.external_schema.gorm.url
  dev = "postgres://bb:bb@localhost/bb?sslmode=disable"
  migration {
    dir = "file://migrations"
  }
  format {
    migrate {
      diff = "{{ sql . \"  \" }}"
    }
  }
}

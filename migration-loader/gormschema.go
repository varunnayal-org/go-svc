package main

import (
	"errors"
	"fmt"
	"strings"

	// "ariga.io/atlas-go-sdk/recordriver"
	"ariga.io/atlas-go-sdk/recordriver"
	"gorm.io/driver/postgres"
	"gorm.io/gorm"
)

type IEnum interface {
	Name() string
	All() []string
}

type TablePreCreator interface {
	TablePreCreate(txn *gorm.DB) *gorm.DB
}

type TableNamer interface {
	TableName() string
}

// Loader is a Loader for gorm schema.
type Loader struct {
	dialect string
	di      gorm.Dialector
}

// New returns a new Loader.
func New(dialect string) *Loader {
	return &Loader{dialect: dialect, di: postgres.New(postgres.Config{
		DriverName: "recordriver",
		DSN:        "gorm",
	})}
}

func toString(list []string) string {
	var s string

	for i, v := range list {
		if i == len(list)-1 {
			s += fmt.Sprintf("'%s'", v)
			continue
		}

		s += fmt.Sprintf("'%s',", v)
	}

	return s
}

func processTable(txn *gorm.DB, migrationObj interface{}) *gorm.DB {
	if v, ok := migrationObj.(TableNamer); ok {
		return txn.Table(v.TableName())
	}

	return txn
}

func processPreCreate(txn *gorm.DB, migrationObj interface{}) *gorm.DB {
	if v, ok := migrationObj.(TablePreCreator); ok {
		return v.TablePreCreate(txn)
	}

	return txn
}

func (l *Loader) Load(modelsOrStatements ...any) (string, error) {
	db, err := gorm.Open(l.di, &gorm.Config{})
	if err != nil {
		return "", err
	}

	// loop over modelsOrStatements
	for i := 0; i < len(modelsOrStatements); i++ {
		switch migrationObj := modelsOrStatements[i].(type) {
		case IEnum: // to create enum
			stmt := fmt.Sprintf(`
DO $$ BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = '%s') THEN
      CREATE TYPE %s AS ENUM (%s);
  END IF;
EXCEPTION
	WHEN duplicate_object THEN null;
END $$
`,
				migrationObj.Name(), migrationObj.Name(), toString(migrationObj.All()))
			stmt = fmt.Sprintf(`CREATE TYPE %s AS ENUM (%s)`, migrationObj.Name(), toString(migrationObj.All()))
			db.Exec(stmt)

		case string: // or execute SQL strings as it is
			db.Exec(migrationObj)

		default:
			if err := db.Transaction(func(tx *gorm.DB) error {
				tx = processPreCreate(tx, migrationObj)
				tx = processTable(tx, migrationObj)
				return tx.AutoMigrate(migrationObj)
			}); err != nil {
				return "", err
			}
		}
	}

	s, ok := recordriver.Session("gorm")
	if !ok {
		return "", errors.New("no session found")
	}

	var sb strings.Builder
	stmtExistMap := make(map[string]bool)

	for _, stmt := range s.Statements {
		if stmtExistMap[stmt] {
			continue
		}

		stmtExistMap[stmt] = true

		sb.WriteString(stmt)
		sb.WriteString(";\n")
	}

	return sb.String(), nil
}

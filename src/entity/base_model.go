package entity

import (
	"time"
)

type BaseModel struct {
	ID        string    `gorm:"primaryKey"`
	CreatedAt time.Time `gorm:"not null"`
	UpdatedAt time.Time `gorm:"not null"`
}

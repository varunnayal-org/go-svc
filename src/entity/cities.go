package entity

import "github.com/varunnayal/go-migrations/src/enum"

type City struct {
	BaseModel
	IsActive bool              `gorm:"default:true"`
	Name     string            `gorm:"type:varchar(100);not null"`
	Category enum.CityCategory `gorm:"type:city_category_enum;not null"`
	Status   string
}

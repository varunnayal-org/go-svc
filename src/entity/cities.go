package entity

type City struct {
	BaseModel
	IsActive bool   `gorm:"default:true"`
	Name     string `gorm:"type:varchar(100);not null"`
}

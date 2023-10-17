package enum

// CityCategory should map to city_category_enum
type CityCategory string

const (
	TwinCity   CityCategory = "Twin"
	MegaCity   CityCategory = "Mega"
	GardenCity CityCategory = "Garden"
)

// AllCategories returns all possible values for CityCategory
func (c CityCategory) All() []string {
	return []string{
		string(TwinCity),
		string(MegaCity),
		string(GardenCity),
	}
}

// Name returns the name of the enum
func (c CityCategory) Name() string {
	return "city_category_enum"
}

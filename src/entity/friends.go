package entity

type Friends struct {
	UserID   string `gorm:"not null; uniqueIndex:idx_user_id_friend_id;"`
	FriendID string `gorm:"not null; uniqueIndex:idx_user_id_friend_id;"`
	Active   bool
}

func (c Friends) TableName() string {
	return "friends"
}

package repository

import (
	"database/sql"

	"image-gallery-backend/internal/models"
)

type HashtagRepository struct {
	db *sql.DB
}

func NewHashtagRepository(db *sql.DB) *HashtagRepository {
	return &HashtagRepository{db: db}
}

// GetAllWithCount ดึง hashtag ทั้งหมดพร้อมจำนวนรูปภาพ
func (r *HashtagRepository) GetAllWithCount() ([]models.HashtagWithCount, error) {
	rows, err := r.db.Query(`
		SELECT h.id, h.name, COUNT(ih.image_id) AS image_count
		FROM hashtags h
		LEFT JOIN image_hashtags ih ON h.id = ih.hashtag_id
		GROUP BY h.id
		ORDER BY image_count DESC
	`)
	if err != nil {
		return nil, err
	}
	defer rows.Close()

	var hashtags []models.HashtagWithCount
	for rows.Next() {
		var h models.HashtagWithCount
		if err := rows.Scan(&h.ID, &h.Name, &h.ImageCount); err != nil {
			return nil, err
		}
		hashtags = append(hashtags, h)
	}

	if hashtags == nil {
		hashtags = []models.HashtagWithCount{}
	}

	return hashtags, nil
}

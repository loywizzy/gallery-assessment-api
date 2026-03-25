package repository

import (
	"database/sql"
	"encoding/json"

	"image-gallery-backend/internal/models"
)

type ImageRepository struct {
	db *sql.DB
}

func NewImageRepository(db *sql.DB) *ImageRepository {
	return &ImageRepository{db: db}
}

// GetImages ดึงรูปภาพพร้อม hashtags (รองรับ filter + pagination)
func (r *ImageRepository) GetImages(page, limit int, hashtag string) ([]models.Image, int, error) {
	offset := (page - 1) * limit
	var rows *sql.Rows
	var err error
	var total int

	if hashtag != "" {
		// Count total for this hashtag
		err = r.db.QueryRow(`
			SELECT COUNT(DISTINCT i.id)
			FROM images i
			INNER JOIN image_hashtags ih ON i.id = ih.image_id
			INNER JOIN hashtags h ON ih.hashtag_id = h.id AND h.name = $1
		`, hashtag).Scan(&total)
		if err != nil {
			return nil, 0, err
		}

		// Fetch filtered images
		rows, err = r.db.Query(`
			SELECT i.id, i.title, i.url, i.width, i.height, i.description, i.created_at,
				COALESCE(
					(SELECT json_agg(json_build_object('id', h2.id, 'name', h2.name))
					 FROM image_hashtags ih2
					 JOIN hashtags h2 ON ih2.hashtag_id = h2.id
					 WHERE ih2.image_id = i.id), '[]'
				) AS hashtags
			FROM images i
			INNER JOIN image_hashtags ih ON i.id = ih.image_id
			INNER JOIN hashtags h ON ih.hashtag_id = h.id AND h.name = $1
			ORDER BY i.created_at DESC
			LIMIT $2 OFFSET $3
		`, hashtag, limit, offset)
	} else {
		// Count total
		err = r.db.QueryRow(`SELECT COUNT(*) FROM images`).Scan(&total)
		if err != nil {
			return nil, 0, err
		}

		// Fetch all images
		rows, err = r.db.Query(`
			SELECT i.id, i.title, i.url, i.width, i.height, i.description, i.created_at,
				COALESCE(
					(SELECT json_agg(json_build_object('id', h.id, 'name', h.name))
					 FROM image_hashtags ih
					 JOIN hashtags h ON ih.hashtag_id = h.id
					 WHERE ih.image_id = i.id), '[]'
				) AS hashtags
			FROM images i
			ORDER BY i.created_at DESC
			LIMIT $1 OFFSET $2
		`, limit, offset)
	}

	if err != nil {
		return nil, 0, err
	}
	defer rows.Close()

	var images []models.Image
	for rows.Next() {
		var img models.Image
		var hashtagsJSON string
		err := rows.Scan(&img.ID, &img.Title, &img.URL, &img.Width, &img.Height,
			&img.Description, &img.CreatedAt, &hashtagsJSON)
		if err != nil {
			return nil, 0, err
		}
		if err := json.Unmarshal([]byte(hashtagsJSON), &img.Hashtags); err != nil {
			img.Hashtags = []models.Hashtag{}
		}
		images = append(images, img)
	}

	if images == nil {
		images = []models.Image{}
	}

	return images, total, nil
}

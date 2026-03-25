package models

import "time"

type Image struct {
	ID          int       `json:"id"`
	Title       string    `json:"title"`
	URL         string    `json:"url"`
	Width       int       `json:"width"`
	Height      int       `json:"height"`
	Description *string   `json:"description"`
	CreatedAt   time.Time `json:"created_at"`
	Hashtags    []Hashtag `json:"hashtags"`
}

type Hashtag struct {
	ID   int    `json:"id"`
	Name string `json:"name"`
}

type HashtagWithCount struct {
	ID         int    `json:"id"`
	Name       string `json:"name"`
	ImageCount int    `json:"image_count"`
}

type ImagesResponse struct {
	Data    []Image `json:"data"`
	Page    int     `json:"page"`
	Limit   int     `json:"limit"`
	Total   int     `json:"total"`
	HasMore bool    `json:"has_more"`
}

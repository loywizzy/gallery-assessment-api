package handlers

import (
	"net/http"
	"strconv"
	"strings"

	"image-gallery-backend/internal/models"
	"image-gallery-backend/internal/repository"

	"github.com/gin-gonic/gin"
)

type ImageHandler struct {
	repo *repository.ImageRepository
}

func NewImageHandler(repo *repository.ImageRepository) *ImageHandler {
	return &ImageHandler{repo: repo}
}

// GetImages — GET /api/images?page=1&limit=15&hashtags=nature,city
func (h *ImageHandler) GetImages(c *gin.Context) {
	page, _ := strconv.Atoi(c.DefaultQuery("page", "1"))
	limit, _ := strconv.Atoi(c.DefaultQuery("limit", "15"))
	hashtagsParam := c.Query("hashtags")

	if page < 1 {
		page = 1
	}
	if limit < 1 || limit > 50 {
		limit = 15
	}

	var hashtags []string
	if hashtagsParam != "" {
		hashtags = strings.Split(hashtagsParam, ",")
	}

	images, total, err := h.repo.GetImages(page, limit, hashtags)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	hasMore := (page * limit) < total

	c.JSON(http.StatusOK, models.ImagesResponse{
		Data:    images,
		Page:    page,
		Limit:   limit,
		Total:   total,
		HasMore: hasMore,
	})
}

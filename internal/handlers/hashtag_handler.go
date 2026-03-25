package handlers

import (
	"net/http"

	"image-gallery-backend/internal/repository"

	"github.com/gin-gonic/gin"
)

type HashtagHandler struct {
	repo *repository.HashtagRepository
}

func NewHashtagHandler(repo *repository.HashtagRepository) *HashtagHandler {
	return &HashtagHandler{repo: repo}
}

// GetHashtags — GET /api/hashtags
func (h *HashtagHandler) GetHashtags(c *gin.Context) {
	hashtags, err := h.repo.GetAllWithCount()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, hashtags)
}

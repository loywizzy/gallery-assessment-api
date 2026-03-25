package router

import (
	"image-gallery-backend/internal/config"
	"image-gallery-backend/internal/handlers"
	"image-gallery-backend/internal/repository"

	"github.com/gin-contrib/cors"
	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()

	// CORS — อนุญาต Frontend เข้าถึง
	r.Use(cors.New(cors.Config{
		AllowOrigins:     []string{"http://localhost:5173", "http://localhost:3000", "https://gallery-assessment-web.vercel.app"},
		AllowMethods:     []string{"GET"},
		AllowHeaders:     []string{"Origin", "Content-Type"},
		AllowCredentials: true,
	}))

	// Repositories
	imageRepo := repository.NewImageRepository(config.DB)
	hashtagRepo := repository.NewHashtagRepository(config.DB)

	// Handlers
	imageHandler := handlers.NewImageHandler(imageRepo)
	hashtagHandler := handlers.NewHashtagHandler(hashtagRepo)

	// Routes
	api := r.Group("/api")
	{
		api.GET("/images", imageHandler.GetImages)
		api.GET("/hashtags", hashtagHandler.GetHashtags)
	}

	// Health check
	r.GET("/health", func(c *gin.Context) {
		c.JSON(200, gin.H{"status": "ok"})
	})

	return r
}

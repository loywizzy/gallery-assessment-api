package main

import (
	"fmt"
	"log"
	"os"

	"image-gallery-backend/internal/config"
	"image-gallery-backend/internal/router"
)

func main() {
	// Load environment
	config.LoadEnv()

	// Connect to database
	config.ConnectDB()
	defer config.DB.Close()

	// Setup router
	r := router.SetupRouter()

	// Start server
	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}

	fmt.Printf("🚀 Server starting on :%s\n", port)
	if err := r.Run(":" + port); err != nil {
		log.Fatalf("❌ Failed to start server: %v", err)
	}
}

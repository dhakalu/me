package routes

import (
	"github.com/gin-gonic/gin"
)

type routes struct {
	router *gin.Engine
}

// Creates/Initializes routes for all of the application
func NewRoutes() routes {
	r := routes{
		router: gin.Default(),
	}
	r.router.Use(CORSMiddleware())
	v1 := r.router.Group("/api/v1")
	r.addSwagerRoutes(v1)
	r.addProjectRoutes(v1)
	return r
}

func CORSMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		c.Writer.Header().Set("Access-Control-Allow-Origin", "*")
		c.Writer.Header().Set("Access-Control-Allow-Credentials", "true")
		c.Writer.Header().Set("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, accept, origin, Cache-Control, X-Requested-With")
		c.Writer.Header().Set("Access-Control-Allow-Methods", "POST, OPTIONS, GET, PUT")

		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(204)
			return
		}

		c.Next()
	}
}

func (r routes) Run(addr ...string) error {
	gin.SetMode(gin.ReleaseMode)
	return r.router.Run(":8082")
}

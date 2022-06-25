package routes

import (
	_ "service/projects/docs" // you need to update github.com/rizalgowandy/go-swag-sample with your own project path

	"github.com/gin-gonic/gin"
	swaggerFiles "github.com/swaggo/files"
	ginSwagger "github.com/swaggo/gin-swagger"
)

func (r routes) addSwagerRoutes(rg *gin.RouterGroup) {
	rg.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

}

package main

import (
	routes "service/projects/routes"
)

// @title Contract API
// @version 1.0
// @description Rest APIs to serve request related to contract model/object.
// @termsOfService http://swagger.io/terms/

// @contact.name API Support
// @contact.url http://www.swagger.io/support
// @contact.email support@swagger.io

// @license.name Apache 2.0
// @license.url http://www.apache.org/licenses/LICENSE-2.0.html

// @host localhost:8082
// @BasePath /
// @schemes http
func main() {
	allRoutes := routes.NewRoutes()

	allRoutes.Run()
}

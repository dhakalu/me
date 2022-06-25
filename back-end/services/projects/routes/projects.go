package routes

import (
	"strconv"

	"service/projects/controllers"
	"service/projects/services"

	"github.com/gin-gonic/gin"
	log "github.com/sirupsen/logrus"
)

var (
	projectService    services.ProjectService       = services.NewProjectService()
	projectController controllers.ProjectController = controllers.NewProjectController(projectService)
)

func (r routes) addProjectRoutes(rg *gin.RouterGroup) {
	biddingRoutes := rg.Group("/projects")
	biddingRoutes.POST("/", createProject)
	biddingRoutes.GET("/", findProjects)
	biddingRoutes.GET("/:id", findProjectById)
}

// @Summary Create a project
// @Description Adds a project to the database.
// @Tags project-app
// @Accept json
// @Produce json
// @Success 200 {object} entities.Project
// @Failure 400 {object} routes.ErrorResponse
// @Router /api/v1/projects [post]
// @Param project body dtos.ProjectCreateRequest true "JSON object representing a school."
func createProject(ctx *gin.Context) {
	record, err := projectController.Save(ctx)
	if err != nil {
		log.Error(err.Error())
		ctx.JSON(400, NewErrorResponse(err.Error()))
	} else {
		ctx.JSON(200, record)
	}
}

//@Summary Returns the list of projects on the database for the user query. //todo Add filters to allow user to narrow down the list of projects
//@Description Use this endpoint when you need to show the list of projects to the user. Right now the filtering capabilities are not enabled but they will be added in the future as we make progress.
// @Produce json
// @Accept json
// @Tags project-app, bidding-app
// @Success 200 {object} entities.Project
// @Failure 400 {object} routes.ErrorResponse
// @Failure 500 {object} routes.ErrorResponse - Uncaught errors. When client encounter this error, its usually a flaw in the business logic. Please report these errors to the admins so these errors can be caught  and more appropriate response and response status code is sent.
// @param //todo this is where we would add filters on upcoming PIs
func findProjects(ctx *gin.Context) {
	projects, err := projectController.FindAll()
	if err != nil {
		log.Error(err.Error())
		ctx.JSON(400, NewErrorResponse(err.Error()))
	} else {
		ctx.JSON(200, projects)
	}
}

// @Summary Fetch project by its id
// @Description Given the id of project as the path variable, this endpoint returns the detail about that project. If project does not exist it returns 400 status code.
// @Tags project-app, bidding-app
// @Accept json
// @Produce json
// @Success 200 {object} entities.Project
// @Failure 400 {object} routes.ErrorResponse
// @Router /api/v1/projects [get]
func findProjectById(ctx *gin.Context) {
	id, _ := strconv.Atoi(ctx.Param("id"))
	project, err := projectController.FindById(int64(id))
	if err == nil {
		ctx.JSON(200, project)
	} else {
		ctx.JSON(400, NewErrorResponse("Could not find company with id: "+ctx.Param("id")))
	}
}

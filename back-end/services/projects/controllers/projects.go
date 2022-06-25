package controllers

import (
	"service/projects/dtos"
	"service/projects/entities"
	"service/projects/services"

	"github.com/gin-gonic/gin"
)

type ProjectController interface {
	Save(ctx *gin.Context) (*entities.Project, error)
	FindAll() ([]entities.Project, error)
	FindById(projectId int64) (*entities.Project, error)
}

type projectController struct {
	service services.ProjectService
}

func NewProjectController(service services.ProjectService) ProjectController {
	return projectController{
		service: service,
	}
}

func (c projectController) Save(ctx *gin.Context) (*entities.Project, error) {
	var project dtos.CreateProjectRequest
	err := ctx.BindJSON(&project)
	if err != nil {
		// todo return a custom error so it can be handled in the route properly
		return nil, err
	}
	return c.service.Save(project)
}

func (c projectController) FindAll() ([]entities.Project, error) {
	return c.service.FindAll()
}

func (c projectController) FindById(projectId int64) (*entities.Project, error) {
	return c.service.FindById(projectId)
}

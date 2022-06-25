package services

import (
	"time"

	"service/projects/dtos"
	"service/projects/entities"
	"service/projects/repositories"

	"github.com/ulule/deepcopier"
)

type ProjectService interface {
	Save(project dtos.CreateProjectRequest) (*entities.Project, error)
	FindAll() ([]entities.Project, error)
	FindById(id int64) (*entities.Project, error)
}

type projectService struct {
	repo repositories.ProjectRepository
}

func NewProjectService() ProjectService {
	return &projectService{
		repo: repositories.NewProjectRepository(),
	}
}

func (s *projectService) Save(project dtos.CreateProjectRequest) (*entities.Project, error) {
	projectEntity := entities.Project{}
	// todo is this right way to do this?
	deepcopier.Copy(&project).To(&projectEntity)
	projectEntity.CreatedAt = time.Now()
	projectEntity.UpdatedAt = time.Now()
	return s.repo.Save(projectEntity)
}

func (s *projectService) FindAll() ([]entities.Project, error) {
	return s.repo.FindAll()
}

func (s *projectService) FindById(id int64) (*entities.Project, error) {
	return s.repo.FindById(id)
}

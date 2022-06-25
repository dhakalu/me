package repositories

import (
	"context"
	"fmt"

	databases "service/projects/database"
	"service/projects/entities"

	"github.com/jackc/pgx/v4/pgxpool"
)

type ProjectRepository interface {
	Save(project entities.Project) (*entities.Project, error)
	FindAll() ([]entities.Project, error)
	FindById(projectId int64) (*entities.Project, error)
}

type projectRepository struct {
	db pgxpool.Pool
}

func NewProjectRepository() ProjectRepository {
	return &projectRepository{
		db: *databases.CreateConnection(),
	}
}

func (r *projectRepository) FindAll() ([]entities.Project, error) {

	sql := "SELECT * FROM projects"
	var projects []entities.Project
	rows, queryError := r.db.Query(context.Background(), sql)
	if queryError != nil {
		fmt.Printf("Could not read project data because of the error \n %v \n", queryError)
		return projects, queryError
	} else {
		for rows.Next() {
			var project entities.Project
			err := rows.Scan(
				&project.Id,
				&project.Name,
				&project.Description,
				&project.CreatedAt,
				&project.UpdatedAt,
			)
			if err != nil {
				continue
			} else {
				projects = append(projects, project)
			}
		}
	}
	return projects, nil
}

func (r *projectRepository) FindById(projectId int64) (*entities.Project, error) {
	var project entities.Project
	sql := `Select * from projects where id=$1`
	err := r.db.QueryRow(context.Background(), sql, projectId).Scan(
		&project.Id,
		&project.Name,
		&project.Description,
		&project.CreatedAt,
		&project.UpdatedAt,
	)

	if err != nil {
		return nil, err
	} else {
		return &project, nil
	}
}

func (r *projectRepository) Save(project entities.Project) (*entities.Project, error) {
	sql := `INSERT INTO projects (
		name,
		description,
		created_at,
		updated_at
	) VALUES ($1, $2, $3, $4) RETURNING id;
	`
	err := r.db.QueryRow(context.Background(),
		sql,
		project.Name,
		project.Description,
		project.CreatedAt,
		project.UpdatedAt,
	).Scan(&project.Id)

	if err != nil {
		fmt.Printf("%v \n", err)
		return nil, err
	} else {
		return &project, nil

	}
}

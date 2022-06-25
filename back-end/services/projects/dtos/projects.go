package dtos

type CreateProjectRequest struct {
	// Name of the project.
	Name string `json:"name"`
	// short description of the project.
	Description string `json:"description"`
	//---------- OPTIONAL ----------------/
}

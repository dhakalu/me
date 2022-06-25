package routes

type ErrorResponse struct {
	Message string `json:"message"`
}

func NewErrorResponse(message string) ErrorResponse {
	var err ErrorResponse
	err.Message = message
	return err
}

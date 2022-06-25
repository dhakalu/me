package database

import (
	"context"
	"fmt"
	"os"

	"github.com/jackc/pgx/v4/pgxpool"
)

func ConnectionString() string {
	host := os.Getenv("SERVICE_HOST")
	port := os.Getenv("SERVICE_DB_PORT")
	user := os.Getenv("SERVICE_DB_USER")
	password := os.Getenv("SERVICE_DB_PASSWORD")
	databaseName := os.Getenv("SERVICE_DB_DATABASE_NAME")
	return fmt.Sprintf("postgres://%v:%v@%v:%v/%v", user, password, host, port, databaseName)
}

func CreateConnection() *pgxpool.Pool {

	pgSQLConnectionString := ConnectionString()

	var err error
	var pool *pgxpool.Pool
	pool, err = pgxpool.Connect(context.Background(), pgSQLConnectionString)

	if err != nil {
		panic(err)
	}
	err = pool.Ping(context.Background())
	if err != nil {
		panic(err)
	}
	return pool
}

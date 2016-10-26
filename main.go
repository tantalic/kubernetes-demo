package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
)

var (
	Version = "1.0.0"
)

func main() {
	log.Println("Listening on :80")

	http.HandleFunc("/", hello)
	http.ListenAndServe(":80", nil)
}

func hello(resp http.ResponseWriter, req *http.Request) {
	log.Println("Handling request")

	who := "World"
	who, success := os.LookupEnv("WHO")
	if !success {
		who = "World"
	}

	node, err := os.Hostname()
	if err != nil {
		node = "Unkown Node"
	}

	out := fmt.Sprintf(`
		<h1>Hello %s</h1>
		<h2>v%s</h2>
		<h2>%s</h2>
	`, who, Version, node)

	resp.Write([]byte(out))
}

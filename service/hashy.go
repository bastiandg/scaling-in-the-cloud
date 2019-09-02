package main

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"golang.org/x/crypto/bcrypt"
	"log"
	"net/http"
	"time"
)

func handler(w http.ResponseWriter, r *http.Request) {
	timeStamp := new(bytes.Buffer)
	binary.Write(timeStamp, binary.LittleEndian, time.Now().UnixNano())
	hash, _ := bcrypt.GenerateFromPassword(timeStamp.Bytes(), 12)
	fmt.Fprintf(w, string(hash))
}

func healthz(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "ok")
}

func main() {
	http.HandleFunc("/", handler)
	http.HandleFunc("/healthz", healthz)
	log.Fatal(http.ListenAndServe(":80", nil))
}

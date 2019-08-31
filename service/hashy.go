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
	hash, _ := bcrypt.GenerateFromPassword(timeStamp.Bytes(), 10)
	fmt.Fprintf(w, string(hash))
}

func main() {
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":80", nil))
}

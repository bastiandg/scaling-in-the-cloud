package main

import (
	"fmt"
	"log"
	"math/big"
	"net/http"
	"time"
)

func handler(w http.ResponseWriter, r *http.Request) {
	a := makeTimestamp()
	if big.NewInt(a).ProbablyPrime(0) {
		fmt.Fprintf(w, "It's prime time\n")
	} else {
		fmt.Fprintf(w, "the next prime time is %d\n", nextPrimetime(a))
	}
}

func main() {
	http.HandleFunc("/", handler)
	log.Fatal(http.ListenAndServe(":80", nil))
}

func makeTimestamp() int64 {
	return time.Now().UnixNano()
}

func nextPrimetime(prime int64) int64 {
	for i := int64(0); i < 10000; i++ {
		if big.NewInt(prime + i).ProbablyPrime(0) {
			return prime + i
		}
	}
	return -1
}

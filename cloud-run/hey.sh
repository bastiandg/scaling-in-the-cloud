#!/bin/bash

for i in $(seq 10) ; do
	hey -z 1m \
		-q "$((i * 10))" \
		-c "$((i * 5))" \
		"$RUN_URL"
done

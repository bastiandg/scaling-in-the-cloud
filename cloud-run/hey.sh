#!/bin/bash

for i in $(seq 10) ; do
	hey -z 1m \
		-c "$((i * 5))" \
		"$RUN_URL"
done

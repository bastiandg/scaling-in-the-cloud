#!/bin/bash

RUN_URL="$(gcloud run services list --format='value(status.url)' --platform managed)"

for i in $(seq 10) ; do
	hey -z 1m \
		-q "$((i * 10))" \
		-c "$((i * 5))" \
		"$RUN_URL"
done

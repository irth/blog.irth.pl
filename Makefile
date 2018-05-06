build: docs

.PHONY: build watch serve

docs: $(wildcard posts/*.md) Makefile
	mv docs/CNAME .
	blag \
		-input posts \
		-output docs \
		-title "irth's blag" \
		-baseurl https://blog.irth.pl \
		-disqus irth-blag \
		-google UA-93070646-1 \
		-cookies 
	mv CNAME docs/

watch:
	while true; do \
		make build; \
		inotifywait -qre close_write .; \
	done

serve:
	cd docs && python -m http.server

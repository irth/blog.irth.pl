build: docs

.PHONY: build watch serve

docs: $(wildcard posts/*.md) Makefile
	blag \
		-input posts \
		-output docs \
		-baseurl https://blog.irth.pl \
		-disqus irth-blag \
		-google UA-93070646-1 \
		-cookies

watch:
	while true; do \
		make build; \
		inotifywait -qre close_write .; \
	done

serve:
	cd docs && python -m http.server

.PHONY: build build-dev _build watch serve

build:
	make URL=https://blog.irth.pl _build

build-dev:
	make URL=http://localhost:8000 _build

_build: $(wildcard posts/*.md) Makefile
	TZ=Europe/Warsaw blag \
		-input posts \
		-output docs \
		-theme theme \
		-title "irth's blag" \
		-baseurl ${URL} \
		-disqus irth-blag \
		-short 700 
	cp CNAME docs/

watch:
	while true; do \
		make build; \
		inotifywait -qre close_write .; \
	done

serve:
	make build-dev
	cd docs && python -m http.server

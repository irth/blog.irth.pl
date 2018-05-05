build: docs

.PHONY: build watch serve

docs: $(wildcard posts/*.md)
	blag -input posts -output docs

watch:
	while true; do \
		make build; \
		inotifywait -qre close_write .; \
	done

serve:
	cd docs && python -m http.server

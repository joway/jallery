build: build-images build-index build-web

build-index:
	node src/scripts/gen.js

build-web:
	npm run build

build-images:
	./bin/build-images.sh

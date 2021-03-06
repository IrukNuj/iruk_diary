.PHONY: build server public clean new edit

HUGO := hugo
PREFIX := $(shell date +post/%Y-%m-%d)
IMGDIR := $(shell date +static/%Y/%m/%d/)

build: clean
	$(HUGO)

server:
	$(HUGO) server -D

public: clean
	$(HUGO) --baseURL http://127.0.0.1:8000/
	cd public; python -m http.server 8000 --bind 127.0.0.1

clean:
	@-rm -r public/
	@-find static -type d -empty | xargs rmdir

new:
	@: dummy

edit:
	code ./content/post/

.DEFAULT:
	@case $(firstword $(MAKECMDGOALS)) in \
	new) \
		mkdir -p $(IMGDIR)/$@; \
		$(HUGO) new $(PREFIX)-$@.md --editor code; \
		;; \
	esac

# Makefile for building documentation

DOCC_JSON_PRETTYPRINT=YES
export DOCC_JSON_PRETTYPRINT

.PHONY: all local deploy run commit

# Default target
all: local deploy

# Prebuild step to set environment variables
prebuild:
	@rm -r Notes.docc/Topics
	@rm -r Notes.docc/ImageResources
	@cp -r ../Jumbleum/Notes.docc/NP/CCAs/Ambassadors/Topics Notes.docc/Topics
	@cp -r ../Jumbleum/Notes.docc/NP/CCAs/Ambassadors/Resources Notes.docc/ImageResources
	@echo "Setting environment variables"
	@export DOCC_JSON_PRETTYPRINT="YES"

# Build for local environment
# add then remove Topics after building
local: prebuild
	xcrun docc convert . --transform-for-static-hosting
	@echo "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><meta http-equiv=\"refresh\" content=\"0;url=/documentation/home\"><title>Redirecting...</title></head><body><p>If you are not redirected automatically, follow this <a href=\"/documentation/home\">link</a>.</p></body></html>" > .docc-build/index.html
	@echo "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><meta http-equiv=\"refresh\" content=\"0;url=/documentation/home\"><title>Redirecting...</title></head><body><p>If you are not redirected automatically, follow this <a href=\"/documentation/home\">link</a>.</p></body></html>" > .docc-build/documentation/index.html
	@cp -a .docc-build/images/Notes/. .docc-build/images/

# Build for deployment
# add then remove Topics after building
deploy: prebuild
	xcrun docc convert . --transform-for-static-hosting --output-dir docs --hosting-base-path "NPAmbsGuide"
	@echo "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><meta http-equiv=\"refresh\" content=\"0;url=/NPAmbsGuide/documentation/home\"><title>Redirecting...</title></head><body><p>If you are not redirected automatically, follow this <a href=\"/NPAmbsGuide/documentation/home\">link</a>.</p></body></html>" > docs/index.html
	@echo "<!DOCTYPE html><html lang=\"en\"><head><meta charset=\"UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><meta http-equiv=\"refresh\" content=\"0;url=/NPAmbsGuide/documentation/home\"><title>Redirecting...</title></head><body><p>If you are not redirected automatically, follow this <a href=\"/NPAmbsGuide/documentation/home\">link</a>.</p></body></html>" > docs/documentation/index.html
	@cp -a docs/images/Notes/. docs/images/

# Run the program
run:
	$(info Running the program. The home page is located at http://localhost:8000/documentation/home/)
	@cd .docc-build && python3 -m http.server

# Git commit
commit: deploy
	git add -A
	git commit -m "$(msg)"
	echo "Changes committed"

# Default goal
.DEFAULT_GOAL := all

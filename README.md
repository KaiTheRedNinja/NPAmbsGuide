# NPAmbsGuide

My personal NP Ambassadors Guide

## Build Instructions

To build the notes, CD to the parent directory of Documentation.docc and run the make script.
 - `make`, `make all`, or `make local deploy` to build both local and github pages versions of NPAmbsGuide.
 - `make local` to build only the local version of NPAmbsGuide.
 - `make deploy` to build only the github pages version of NPAmbsGuide.
 - `make run` to run the local version of NPAmbsGuide.
 - `make commit msg="commit msg here"` to build deploy version and commit

Note that we use a custom build of `swift-docc-render`, which provides LaTeX support and other features not 
present in the default version of `swift-docc-render`. It sometimes doesn't apply itself, so if you encounter
issues, run these commands in the terminal:
```shell
export DOCC_HTML_DIR="/path/to/the/jumbleum/dir/dist"
xcrun docc convert . --transform-for-static-hosting
make run
```

Also I didn't include a copy of `dist` inside this repo because honestly I don't expect anybody else to
contribute. If you want to add something to the repo, find a way to contact me.

Visit http://localhost:8000/documentation/home/ to view NPAmbsGuide locally.

Note that by default, the script produces TWO versions of the NPAmbsGuide. 
The first is the one that is hosted locally for debugging, which is gitignored and not included on the github.
The second is the one that is hosted on Github Pages. The local server version is useful for debugging purposes.

BINARY := "bin/jesterplugins"
HOST   := "http://localhost:5000"

# the default task should list all other tasks
@_default:
    just -l

# builds a debug version
@build:
    nimble build

# builds a release version
@release:
    nimble build -d:release

# runs the existing binary
@run:
    {{BINARY}}

# build and runs the server
@br: build run

# watches for source changes and rebuilds and re-runs
@br-watch:
    fd -e .nim | entr -r just br

# make a curl request against the server
@get PATH="":
    curl -s {{HOST}}/{{PATH}}

@bench PATH="status":
    siege -c 8 -r 1000 -b {{HOST}}/{{ PATH }}> /dev/null

@bench-status-write:
    siege -T "application/json" -c 8 -r 1000 -f siege.txt -b > /dev/null

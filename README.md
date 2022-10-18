# Purpose

Simple binary that takes strings and write them into a network socket

Typical usecase, Apache2 use this type of binary to log.
Then you can make a little server to parse and use Apache logs.
More efficiant than inotify or while loop on file.

# Objective

The objective was to quickly learn Dart and its dev environment.

# Makefile rules

## Build

- make build/netlogger.exe : build binary
- make rebuild : rebuild binary ignoring build dir content
- make all : build binary and run tests
- make : build binary and run tests, same as all
- make build : will only create "build" dir, conforming to Dart standards

## Tests

- make test/{test_name} : Run a specific test named {test_name} and save results in logs/{test_name}-{sha1}.log
- make tests : Run all tests and save results in logs/all-{sha1}.log

## Clean

- make clean : remove build dir
- make dist-clean : remove build dir and logs dir

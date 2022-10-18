PROJECT=netlogger

MAIN_DIR=bin
MAIN=$(MAIN_DIR)/$(PROJECT).dart

BUILD_DIR=_build
OUTPUT=$(BUILD_DIR)/$(PROJECT).exe

TESTS_SHA=$(word 1, $(shell sha $(OUTPUT)))
TESTS_FILE=$(TESTS_SHA)
TESTS_OUTPUT=expanded

CC=dart
TYP?=exe
COMPILE=compile $(TYP)
TEST=test

REPORT_DIR=_logs

.SECOND_EXPANTION:
.PHONY: all run clean dist-clean rebuild test tests release build

.packages:
	$(CC) pub install

all: $(OUTPUT) tests

test: tests

tests: rebuild $(REPORT_DIR)
	$(CC) $(TEST) --file-reporter=$(TESTS_OUTPUT):$(REPORT_DIR)/all-$(TESTS_FILE).log

test/%: rebuild $(REPORT_DIR)
	$(CC) $(TEST) --name=$(*) --file-reporter=$(TESTS_OUTPUT):$(REPORT_DIR)/$(*)-$(TESTS_FILE).log

run: $(OUTPUT)
	./$(OUTPUT)

clean:
	rm -f $(OUTPUT)

dist-clean:
	rm -rf $(OUTPUT) $(BUILD_DIR)
	rm -rf $(REPORT_DIR)

rebuild: clean $(OUTPUT)

build: $(OUTPUT)

release: rebuild
	strip $(OUTPUT)

$(REPORT_DIR):
	mkdir -p $(REPORT_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(OUTPUT): $(BUILD_DIR)
	$(CC) $(COMPILE) $(MAIN) -o $(OUTPUT)

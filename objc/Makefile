DERIVED_DATA_DIR=DerivedData/mal
PRODUCTS_DIR=DerivedData/mal/Build/Products
CONFIGURATION=Debug
BIN_DIR=$(PRODUCTS_DIR)/$(CONFIGURATION)
XCODEBUILD=xcodebuild -configuration $(CONFIGURATION) -derivedDataPath $(DERIVED_DATA_DIR)

all: $(BIN_DIR)/step0_repl $(BIN_DIR)/step1_read_print

$(BIN_DIR)/step0_repl: step0_repl/step0_repl/main.m
	$(XCODEBUILD) -scheme step0_repl

STEP1_HEADER_FILES=$(wildcard step1_read_print/step1_read_print/*.h)
STEP1_IMPLEMENTATION_FILES=$(wildcard step1_read_print/step1_read_print/*.m)
$(BIN_DIR)/step1_read_print: $(STEP1_HEADER_FILES) $(STEP1_IMPLEMENTATION_FILES)
	$(XCODEBUILD) -scheme step1_read_print


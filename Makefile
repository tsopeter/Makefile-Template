# Compiler and flags
CC := g++
CFLAGS := -Wall -Wextra -O2 -MMD -MP -std=c++20
LDFLAGS := 

# Directories
SRC_DIR := source
BUILD_DIR := build
BIN := app  # Name of the output binary

# Find all source files recursively
SRC_FILES := $(shell find $(SRC_DIR) -type f -name "*.cpp")
OBJ_FILES := $(patsubst $(SRC_DIR)/%.cpp, $(BUILD_DIR)/%.o, $(SRC_FILES))
DEP_FILES := $(OBJ_FILES:.o=.d)

# Default target: build the app
$(BIN): $(OBJ_FILES)
	$(CC) $(LDFLAGS) $^ -o $@

# Compile each source file into an object file
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

# Include dependency files
-include $(DEP_FILES)

# Clean build files
.PHONY: clean
clean:
	rm -rf $(BUILD_DIR) $(BIN)
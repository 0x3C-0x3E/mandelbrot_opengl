PROJECTNAME = project
OUTPUT_DIR = build

CXX = g++
CXXFLAGS = -Wall -g
INCLUDE_DIRS = -Iinclude/GLFW -Iinclude/glad -Iinclude/KHR $(addprefix -I, $(wildcard src/*/)) -Iinclude/imgui
LIB_DIRS = -Llib
LIBS = -limgui -lglfw3 -lgdi32 -lopengl32

SRC = $(wildcard src/*.c) $(wildcard src/*/*.c)
OBJ = $(patsubst src/%.c, $(OBJ_DIR)/%.o, $(SRC))


default: $(OUTPUT_DIR)/$(PROJECTNAME)


$(OUTPUT_DIR)/$(PROJECTNAME): $(OBJ)
	@mkdir -p $(OUTPUT_DIR)
	@$(CXX) $(OBJ) -o $@ $(LIB_DIRS) $(LIBS) $(CXXFLAGS)


$(OBJ_DIR)/%.o: src/%.c
	@mkdir -p $(dir $@)
	@$(CXX) -c $< -o $@ $(CXXFLAGS) $(INCLUDE_DIRS)
	
clean:
	@echo "Cleaning up..."
	@rm -rf $(OBJ_DIR)
	@rm -f $(OUTPUT_DIR)/$(PROJECTNAME)
	@find $(OUTPUT_DIR) -type f -name '*.o' -delete
	@find $(OUTPUT_DIR) -type f ! -name '*.dll' -delete
	@find $(OUTPUT_DIR) -type d -empty -delete

.PHONY: default clean

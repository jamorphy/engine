CC=cc
SOKOL_SHDC=./lib/sokol-tools-bin/bin/osx_arm64/sokol-shdc
INCLUDES=-Ilib/ -Ilib/sokol-samples/libs

BUILD_DIR=build

TARGET=src/cube-sapp.c
EXEC=exec

all: native web

native:
	$(SOKOL_SHDC) -i src/cube-sapp.glsl -o src/cube-sapp.glsl.h --slang glsl410
	cc $(TARGET) lib/sokol.m -o $(BUILD_DIR)/$(EXEC)_native -fobjc-arc -DSOKOL_GLCORE $(INCLUDES) -framework OpenGL -framework Cocoa -framework AudioToolbox

web:
	$(SOKOL_SHDC) -i src/cube-sapp.glsl -o src/cube-sapp.glsl.h --slang glsl300es
	emcc $(TARGET) lib/sokol.c -o $(BUILD_DIR)/$(EXEC).html $(INCLUDES) -DSOKOL_GLES3 -sUSE_WEBGL2 --shell-file=src/shell.html

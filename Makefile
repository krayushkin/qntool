CXX = g++
CC  = gcc

CFLAGS = -Wall 

CXXFLAGS  = -Wall 
CXXFLAGS += --std=c++11

#PKG_FLAGS = $(shell pkg-config --cflags glib-2.0)
PKG_FLAGS = 

INC_PATHS += -I.
INC_PATHS += -I./include/

#LDFLAGS = -lglib-2.0 -lpthread
LDFLAGS = -lpthread

MKDIR = mkdir -p

# C Source Files
CSOURCES    = gpio-utils.c


# C++ Source Files
CXXSOURCES = QnPacket.cpp  qn_programmer.cpp serial.cpp print.cpp QnPacket.cpp
CXXSOURCES += timing.cpp helper.cpp  

DEPS_H_FILE = 

OBJECTC    = $(CSOURCES:.c=.o)
OBJECTCXX  = $(CXXSOURCES:.cpp=.o)
 
OBJECT_DIRECTORY        = ./bin
OUTPUT_BINARY_DIRECTORY = $(OBJECT_DIRECTORY)
EXE_DIRECTORY			= ./exe

EXE_FILES =	 qntool 

OBJC   = $(patsubst %,$(OUTPUT_BINARY_DIRECTORY)/%,$(OBJECTC))
OBJCXX = $(patsubst %,$(OUTPUT_BINARY_DIRECTORY)/%,$(OBJECTCXX))
EXE    = $(patsubst %,$(EXE_DIRECTORY)/%,$(EXE_FILES))

VPATH  =./main:./drivers:./helper

# Sorting removes duplicates
BUILD_DIRECTORIES := $(sort $(OBJECT_DIRECTORY) $(OUTPUT_BINARY_DIRECTORY))


## Rules start from here

.PHONY: all cleanall clean cleanobj flash nvds version
.DEFAULT_GOAL = all

all: $(EXE_FILES) | $(BUILD_DIRECTORIES)

qntool: $(OBJC) $(OBJCXX) qntool.cpp | $(BUILD_DIRECTORIES)
	@$(CXX) -g -o $@ $^ $(PKG_FLAGS) $(CXXFLAGS) $(LDFLAGS) $(INC_PATHS)
	@echo "********************************** qntool done **********************************"



$(OUTPUT_BINARY_DIRECTORY)/%.o: %.c $(DEPS_H_FILE) | $(BUILD_DIRECTORIES)
	@$(CXX) -g -c -o $@ $< $(PKG_FLAGS) $(CXXFLAGS) $(INC_PATHS)

$(OUTPUT_BINARY_DIRECTORY)/%.o: %.cpp $(DEPS_H_FILE) | $(BUILD_DIRECTORIES)
	@$(CXX) -g -c -o $@ $< $(PKG_FLAGS) $(CXXFLAGS) $(INC_PATHS)


## Create build directories
$(BUILD_DIRECTORIES):
	$(MKDIR) $@

clean: cleanall

cleanall:
	$(RM) -r $(BUILD_DIRECTORIES)
	$(RM) -r $(EXE_FILES)

flash: all
	./qntool --port /dev/ttyS2 --file gpio.bin --gpio gpiochip0 --resetpin 7
qpps: all
	./qntool --port /dev/ttyS2 --file qpps.bin --gpio gpiochip0 --resetpin 7

nvds: all
	./qntool --port /dev/ttyS2 --file nvds.bin --gpio gpiochip0 --resetpin 7 --nvds 

version: all
	./qntool --port /dev/ttyS2 --gpio gpiochip0 --resetpin 7 --version

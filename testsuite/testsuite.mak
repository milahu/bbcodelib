CFG =Release
ifndef CFG
CFG=Release
endif
CC=gcc
CFLAGS=
CXX=g++
CXXFLAGS=$(CFLAGS)
RC=windres -O COFF
ifeq "$(CFG)"  "Debug"
CFLAGS+=-I/usr/include -I../bbcodelib/ -g -W -O0 -D_DEBUG -D_CONSOLE -D_MBCS
LD=$(CXX) $(CXXFLAGS)
LDFLAGS=
TARGET=testsuite.exec
LDFLAGS+=-L../lib
LIF =../../lib/

LIBS+= $(LIF)bbcodelib.so
endif
ifeq "$(CFG)"  "Release"
CFLAGS+=-I/usr/include -I../bbcodelib/ -W -DNDEBUG -D_CONSOLE -D_MBCS
LD=$(CXX) $(CXXFLAGS)
LDFLAGS=
TARGET=testsuite
LDFLAGS+=-L../lib
LIF =../../lib/

LIBS+= $(LIF)bbcodelib.so
endif

.PHONY: all
all: $(TARGET)

%.o: %.c
	$(CC) $(CFLAGS) $(CPPFLAGS) -o $@ -c $<

%.o: %.cc
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $@ -c $<

%.o: %.cpp
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $@ -c $<

%.o: %.cxx
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) -o $@ -c $<

%.res: %.rc
	$(RC) $(CPPFLAGS) -o $@ -i $<

SOURCE_FILES= \
	main.cpp

HEADER_FILES=

SRCS=$(SOURCE_FILES) $(HEADER_FILES) 

OBJS=$(patsubst %.rc,%.res,$(patsubst %.cxx,%.o,$(patsubst %.cpp,%.o,$(patsubst %.cc,%.o,$(patsubst %.c,%.o,$(filter %.c %.cc %.cpp %.cxx %.rc,$(SRCS)))))))

$(TARGET): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS) $(LIBS)

.PHONY: clean
clean:
	-rm -f $(OBJS) $(TARGET) testsuite.dep

.PHONY: depends
depends:
	-$(CXX) $(CXXFLAGS) $(CPPFLAGS) -MM $(filter %.c %.cc %.cpp %.cxx,$(SRCS)) > mailer_demo.dep

-include testsuite.dep
CFG =Release
ifndef CFG
CFG=Release
endif
CC=gcc
CFLAGS=
CXX=g++
CXXFLAGS=$(CFLAGS)
RC=windres -O COFF
#$(LIF)web_catalogue.a
ifeq "$(CFG)"  "Debug"
CFLAGS+= -fPIC -g -W -O0 -D_DEBUG -D_CONSOLE -D_MBCS
LD=$(CXX) $(CXXFLAGS)
LDFLAGS=
LDFLAGS+=-L../../lib
LIF =../../lib/
LIBS=
else

ifeq "$(CFG)"  "Release"
CFLAGS+= -fPIC -W -DNDEBUG -D_CONSOLE -D_MBCS
LD=$(CXX) $(CXXFLAGS)
LDFLAGS=
LDFLAGS+=-L../../lib
LIF =../../lib/
LIBS=
endif
endif

TARGET = /opt/lib/bbcodelib.so

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
	bbcode_parser.cpp\
	bbcode_lexer.cpp \
	bbcode_utils.cpp

HEADER_FILES= \
	bbcode_config.h \
	bbcode_parser.h \
	bbcode_utils.h \
	bbcode_lexer.h

SRCS=$(SOURCE_FILES) $(HEADER_FILES) 

OBJS=$(patsubst %.rc,%.res,$(patsubst %.cxx,%.o,$(patsubst %.cpp,%.o,$(patsubst %.cc,%.o,$(patsubst %.c,%.o,$(filter %.c %.cc %.cpp %.cxx %.rc,$(SRCS)))))))

$(TARGET): $(OBJS)
	$(CXX) -shared -Wl,-soname,$(TARGET) -o $@ $(OBJS)
#	$(AR) $(ARFLAGS) $@ $(OBJS)

.PHONY: clean
clean:
	-rm -f $(OBJS) $(TARGET) bbcodelib.dep

.PHONY: depends
depends:
	-$(CXX) $(CXXFLAGS) $(CPPFLAGS) -MM $(filter %.c %.cc %.cpp %.cxx,$(SRCS)) > index.dep

-include bbcodelib.dep

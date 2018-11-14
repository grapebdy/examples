CROSS_COMPILE=
CC = $(CROSS_COMPILE)gcc
CXX = $(CROSS_COMPILE)g++

CFLAGS += -I../include/ -c -Wall
CXXFLAGS += -I../include/ -c -Wall
LDFLAGS += -L../lib -lpthread -lm

INSTALLDIR="../release/"
TOOLSDIR=$(INSTALLDIR)/tools/

OBJS := arrayloops.o		\
	convar.o		\
	detached.o		\
	dotprod_mutex.o		\
	dotprod_serial.o	\
	hello.o			\
	hello32.o		\
	hello_arg1.o		\
	hello_arg2.o		\
	join.o			\
	mpithreads_serial.o


TARGET =arrayloops		\
	convar			\
	detached		\
	dotprod_mutex		\
	dotprod_serial		\
	hello			\
	hello32			\
	hello_arg1		\
	hello_arg2		\
	join			\
	mpithreads_serial

OBJS1 := mpithreads_threads.o	\
	 bug1.o			\
	 bug1fix.o		\
	 bug2.o			\
	 bug2fix.o		\
	 bug3.o

OBJS2 := bug4.o			\
	 bug4fix.o		\
	 bug5.o			\
	 bug6.o			\
	 bug6fix.o

TARGET1:=mpithreads_threads	\
	 bug1			\
	 bug1fix		\
	 bug2			\
	 bug2fix		\
	 bug3

TARGET2:=bug4			\
	 bug4fix		\
	 bug5			\
	 bug6			\
	 bug6fix

all: build build1 build2

build: $(TARGET)

build1: $(TARGET1)

build2: $(TARGET2)

tmp: $(OBJS) $(OBJS1) $(OBJS2)
	echo "xxxx"

pcie-dlls: pcie-dlls.o
	$(CC) $^ $(LDFLAGS) -ldl -o $@

pcie-tools: pcie-tools.o
	$(CC) $^ $(LDFLAGS) -o $@

pcie-scan: pcie-scan.o
	$(CC) $^ $(LDFLAGS) -o $@

%:%.o
	$(CC) $< $(LDFLAGS) -o $@

%.o:%.c
	$(CC) -o $@ $(CFLAGS) $<

%.o:%.cpp
	$(CXX) -o $@ $(CXXFLAGS) $<

clean:
	@rm -fr *.o $(TARGET) $(TARGET1) $(TARGET2)

install:
	@echo "install testcase...."
	@test -d $(INSTALLDIR) || mkdir $(INSTALLDIR)
	@test -d $(TOOLSDIR) || mkdir $(TOOLSDIR)
	@cp -rf $(TARGET) $(TOOLSDIR)

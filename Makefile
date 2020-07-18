
CFLAGS_DBUS = $(shell pkg-config --cflags --libs dbus-1)
CFLAGS_GIO  = $(shell pkg-config --cflags --libs gio-2.0)
CFLAGS_GIO_UNIX  = $(shell pkg-config --cflags --libs gio-unix-2.0)

CFLAGS = -g -Wall -Werror

all: btspp

btspp: btspp.c profile1-iface.h profile1-iface.c
	gcc $^ -o $@ $(CFLAGS) $(CFLAGS_DBUS) $(CFLAGS_GIO) $(CFLAGS_GIO_UNIX)

profile1-iface.c: btspp.xml
	gdbus-codegen $? --generate-c-code profile1-iface
profile1-iface.h: profile1-iface.c
	@:

clean:
	rm -f btspp profile1-iface.h profile1-iface.c

.PHONY: all clean

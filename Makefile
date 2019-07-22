# dwm - dynamic window manager
# See LICENSE file for copyright and license details.

include config.mk

SRC = drw.c dwm.c util.c
OBJ = ${SRC:.c=.o}

all: options dwm

options:
	@echo dwm build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.h config.mk

config.h:
	@echo creating $@ from config.def.h
	@cp config.def.h $@

dwm: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f dwm config.h *.o

install:
	@echo installing executable file to /usr/local/bin
	@cp -f dwm /usr/local/bin
	@echo installing manual page to /usr/local/man/man1
	@cp -f dwm.1 /usr/local/man/man1/

uninstall:
	@echo removing executable file from /usr/local/bin
	@rm /usr/local/bin/dwm
	@echo removing manual page from /usr/local/man/man1
	@rm /usr/local/man/man1/dwm.1

.PHONY: all options clean install uninstall
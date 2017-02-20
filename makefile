CC = gcc
CFLAGS=-g -Wall -std=c99
LDFLAGS=-lm
FFLAG=-lfl
FLEX = flex
YACC = yacc
BFLAGS=-d --report=all

.l.c:
		$(FLEX) -o $@ $<

.y.c:
	$(YACC) --file-prefix=$* -d $<
	mv $*.tab.c $*.c
	mv $*.tab.h $*.h

.c.o:
	$(CC) -c -o $@ $<

clean:
	rm -f lex.*.c *.o *~ \#*\#

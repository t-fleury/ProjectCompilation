
CC = gcc
CFLAGS = -g -Wall -std=c99
# (F)LEX FLAGS
LFLAGS = -lfl
# YACC FLAGS
YFLAGS = -d --report=all
# .H FILES
INCLUDE = .include/

run:$(F)
ifneq ($(F),)
ifneq ($(ARGS),)
	clear
	echo -n $$(cat $(ARGS)) | ./$(F)
endif
endif

.l.c:
	flex -o $(F).lex.c $(F).lex.l
.y.c:
	@echo -e "\n\033[32;02mCompiling yacc file:" $(F).y "\033[00m"
	@echo -e "\033[32;02mOutput file:" $(F).c "\033[00m"
	yacc -o $(F).c $(YFLAGS) $<
	mv $(F).h $(F).yacc.h
	mv $(F).c $(F).yacc.c
.c.o:
		$(CC) -c -o $@ $< $(LFLAGS)


$(F): $(F).yacc.o $(F).lex.o
	$(CC) -o $@ $^


clean:
	rm -f *.exe *.o *.output *.dot *.png

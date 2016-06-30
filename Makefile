CC = gcc
CFLAGS = -g -std=c99 -Wall -Wextra -Isrc -rdynamic -fomit-frame-pointer
all: $(patsubst %.c, %.out, $(wildcard *.c))
%.out: %.c Makefile
	$(CC) $(CFLAGS) $< -o $@ -lm
clean:
	rm *.out

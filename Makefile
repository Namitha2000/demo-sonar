CC=gcc
CFLAGS=-Wall
TARGET=app

all:
	$(CC) $(CFLAGS) main.c -o $(TARGET)

clean:
	rm -f $(TARGET)

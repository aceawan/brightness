DC ?= dmd
IDC ?= rdmd
NAME ?= brightness

$(name): brightness.d
	$(DC) brightness.d

run: brightness.d
	$(IDC) brightness.d

unittest: brightness.d
	$(DC) -unittest brightness.d

clean:
	rm brightness brightness.o

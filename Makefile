DC ?= dmd
IDC ?= rdmd
NAME ?= brightness

$(name): $(name).d
	$(DC) $(name).d

run: $(name).d
	$(IDC) $(name).d

clean:
	rm $(name) $(name).o

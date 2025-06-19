#
# Makefile for Library
#

src_scrs	= Application.ts
dst_scrs	= $(src_scrs:.ts=.js)

tsc	= npx tsc
tsc_opt	= -t ES2018 --lib "es2017" --declaration --declarationDir types \
	  --typeRoots types \
	  --alwaysStrict --strict --strictNullChecks --pretty

%.js: %.ts
	$(tsc) $(tsc_opt) $<

all: $(dst_scrs)

clean:
	rm -f $(dst_scrs)
	rm -rf types

# <reference path="KiwiLibrary.d.ts"
#$(dst_decl): $(src_decls) types/Transpiler.d.ts
#	cat $(src_decls) > $@
#	cat types/Transpiler.d.ts \
#	| grep -v "<reference path=\"KiwiLibrary.d.ts\"" \
#	| cat >> $@
#
#types/Transpiler.d.ts: $(dst_scrs)



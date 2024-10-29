TARGET   = out/solve
SOURCES  = src/Main.hs src/Parser.hs src/Solver.hs src/Clause.hs src/Simplifications.hs
COMPILER = ghc
FLAGS    = -O2 -Wall

compile:
	$(COMPILER) -o $(TARGET) $(SOURCES)
	rm -f src/*.hi src/*.o

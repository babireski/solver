TARGET   = out/solve
SOURCES  = src/Main.hs src/Parser.hs src/Solver.hs src/Clause.hs
COMPILER = ghc
FLAGS    = -Wall

compile:
	$(COMPILER) -o $(TARGET) $(SOURCES)
	rm -f src/*.hi src/*.o

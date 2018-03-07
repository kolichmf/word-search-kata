# Word Search Kata

A command line tool for solving word search puzzles.

## Getting Started

You can install the command line tool locally by pulling down the project and running `rake install`.  

### Prerequisites

In order to successfully solve a word search puzzle you must have a valid puzzle.  A valid puzzle must adhere to the following rules:

- the first line of the file is a comma separated list of words
- each remaining line is a comma separated list of single characters represeting `the puzzle`

Once you have a valid puzzle file, you may solve the puzzle using the command line by entering the following command:

`wordsearch path/to/your/file`

Alternatively, you may add the gem to your own project and do the following:

```ruby
require 'wordsearch'

wordsearch = Wordsearch.new File.open("path/to/your/file")
wordsearch.search("WORD") # returns an array of coordinates, e.g [[0,0],[0,1],[0,2],[0,3]] or [] if not found
wordsearch.complete # outputs the solution to the puzzle
```

You can find sample puzzles in the `spec/support` directory, for example:

```
FUN,HELLO,PROGRAMMING,RAILS,RSPEC,RUBY,TDD,TESTING,WORLD
P,S,K,K,D,Y,V,U,B,A,J,M,J,F,H,
S,R,W,D,H,M,T,I,M,W,Z,R,S,E,U,
N,R,O,K,A,L,F,Z,V,Q,B,H,L,P,J,
T,S,B,G,D,L,R,O,W,G,V,L,F,U,N,
U,H,K,B,R,C,K,A,I,C,O,G,J,Z,G,
S,T,I,U,V,A,N,J,L,E,Z,F,F,O,D,
K,L,D,O,S,D,M,Y,F,P,K,Y,Q,Q,M,
S,O,I,D,I,E,B,M,S,S,N,W,P,M,I,
Z,T,U,A,O,U,F,J,I,R,P,M,W,K,B,
Q,E,V,M,R,Y,T,L,E,N,U,B,N,D,L,
N,S,U,Q,F,J,D,H,P,U,G,M,P,T,B,
Q,T,N,D,S,M,O,F,C,P,N,Q,E,T,K,
M,I,L,W,N,X,G,L,W,X,K,U,U,M,T,
U,N,Y,W,I,X,G,F,Q,H,N,I,A,J,W,
T,G,O,L,U,E,D,O,E,X,M,Z,T,V,X
```

## Running the tests

To run the test suite, simply run `rake test` or `bundle exec rspec`

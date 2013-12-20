# DownloadCodeword

A codeword is a crossword puzzle with no clues. Instead, every
light is numbered, with each number representing a particular
letter. Solving a codeword is an exercise in contraint-based
searching.

Typically, the setter will give you a small number of letters
for free—they may say that 12 is A and 20 is M.

You can see examples of codewords at

    http://bestforpuzzles.com/daily-codewords/daily-codewords.html
   
Just because it's an interesting play project, I wrote an Elixir
program to solve codewords. That program takes a flat file containing
a list of words in the codeword puzzle, along with a list of the knows.
The word is list simply a list of space-separated numbers, one word
per line. The known list is lines of the form <number>=<letter>.

Creating these files by hand is tedious, so this program downloads
the puzzle definitions from bestforpuzzles.com and converts their
XML definition of the puzzle into out required format.

## Building

```
$ mix deps.get
$ mix escriptize
```

## Running the Program

``` 
$ ./dl_codeword yyyy mm dd >puzzle.cw
```

where _yyyy_, _mm_, and _dd_ are the date of the puzzle.


## Copyright

Copyright © 2013 Dave Thomas, The Pragmatic Programmers
Licensed under the same terms as Elixir


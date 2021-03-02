# My Library

This is a command-based program of building, using, and navigation through a Library.

## How to run the program

### Pre-requisite

Before running the program, make sure the Ruby version you are using is `2.7.2`.

### Command

`bin/my_library.sh`

## Available commands

1. `build_library|[shelf]|[row]|[column]`
2. `put_book|[isbn]|[title]|[author]`
3. `take_book_from|[position]`
4. `find_book|[isbn]`
5. `list_books`
6. `search_books_by_title|[title keyword]`
7. `search_books_by_author|[author keyword]`

## How to run the tests

### Pre-requisite

Before running the test, make sure you have installed the following gems:

1. RSpec (3.10)
2. SimpleCov (0.21.2)

### Command

`rspec -fd`
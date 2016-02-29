# ContentlyAssignment
Assignment from Contently

Write a calculator that can compute simple arithmetic encoded as strings. For instance an input might look like: “2 + 3 / 5”.

Things to consider:
- order of operations
- unit tests

Bonus points:
 - input validation

To complete this assignment fork this Gist and provide your completed work. No more than a few hours should be spent on this. Try to be as complete as possible, but the purpose is more to facilitate a discussion. Feel free to use any language of choice, though Ruby or JavaScript are preferable.


###SUBMISSION###

This program evaluates an equation passed in as a string, respecting the order of operations. This program will evaluate strings containing the following operators:

-PARENTHASIS: '(' or ')'
-EXPONENTS: '^' or '**'
-MULTIPLICATION: 'x' or '*'
-DIVISION: '÷' or '/'
-ADDITION: '+'
-SUBTRACTION: '−' or '-'

The code also contains input validation.

To run code:
 - Make test-unit is installed. Enter "gem install test-unit" on the command line to install
 - To run the tests, type this on the command line: "ruby calculator_test_cases.rb"


## Running the tests

The test cases use a dummy machine (see `test_driver.c`).

To run the tests, execute `make test` on the top level folder.

## Building the tests

To rebuild the test cases, you will need an 68k assembler and linker.
The makefiles use `m68k-elf-as` and `m68k-elf-ld`. 
You can run `make build_tests` from the top level project folder to rebuild the binary images.

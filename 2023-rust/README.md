<img src="./.assets/christmas_ferris.png" width="164">

# 🎄 Advent of Code 2023

Solutions for [Advent of Code](https://adventofcode.com/) in [Rust](https://www.rust-lang.org/).

<!--- benchmarking table --->
## Benchmarks

| Day | Part 1 | Part 2 |
| :---: | :---: | :---:  |
| [Day 1](./src/bin/01.rs) | `64.6µs` | `651.1µs` |
| [Day 2](./src/bin/02.rs) | `42.9µs` | `50.4µs` |
| [Day 3](./src/bin/03.rs) | `445.6µs` | `428.1µs` |
| [Day 4](./src/bin/04.rs) | `103.4µs` | `19.7ms` |
| [Day 5](./src/bin/05.rs) | `30.3µs` | `26.5s` |
| [Day 6](./src/bin/06.rs) | `642.0ns` | `37.2ms` |
| [Day 7](./src/bin/07.rs) | `205.1µs` | `-` |
| [Day 8](./src/bin/08.rs) | `257.5µs` | `1.7ms` |
| [Day 9](./src/bin/09.rs) | `101.1µs` | `-` |

**Total: 26560.95ms**
<!--- benchmarking table --->

## Usage

### Scaffold a day

```sh
# example: `cargo scaffold 1`
cargo scaffold <day>

# output:
# Created module file "src/bin/01.rs"
# Created empty input file "data/inputs/01.txt"
# Created empty example file "data/examples/01.txt"
# ---
# 🎄 Type `cargo solve 01` to run your solution.
```

Individual solutions live in the `./src/bin/` directory as separate binaries. _Inputs_ and _examples_ live in the the `./data` directory.

Every [solution](https://github.com/fspoettel/advent-of-code-rust/blob/main/src/template/commands/scaffold.rs#L9-L35) has _tests_ referencing its _example_ file in `./data/examples`. Use these tests to develop and debug your solutions against the example input.

> [!TIP]
> If a day has different example inputs for both parts, you can use the `read_file_part()` helper in your tests instead of `read_file()`. For example, if this applies to day 1, you can create a second example file `01-2.txt` and invoke the helper like `let result = part_two(&advent_of_code::template::read_file_part("examples", DAY, 2));` to read it in `test_part_two`.

> [!TIP]
> when editing a solution, `rust-analyzer` will display buttons for running / debugging unit tests above the unit test blocks.

### Download input & description for a day

> [!IMPORTANT] 
> This command requires [installing the aoc-cli crate](#configure-aoc-cli-integration).

```sh
# example: `cargo download 1`
cargo download <day>

# output:
# [INFO  aoc] 🎄 aoc-cli - Advent of Code command-line tool
# [INFO  aoc_client] 🎅 Saved puzzle to 'data/puzzles/01.md'
# [INFO  aoc_client] 🎅 Saved input to 'data/inputs/01.txt'
# ---
# 🎄 Successfully wrote input to "data/inputs/01.txt".
# 🎄 Successfully wrote puzzle to "data/puzzles/01.md".
```

### Run solutions for a day

```sh
# example: `cargo solve 01`
cargo solve <day>

# output:
#     Finished dev [unoptimized + debuginfo] target(s) in 0.13s
#     Running `target/debug/01`
# Part 1: 42 (166.0ns)
# Part 2: 42 (41.0ns)
```

The `solve` command runs your solution against real puzzle inputs. To run an optimized build of your code, append the `--release` flag as with any other rust program.

By default, `solve` executes your code once and shows the execution time. If you append the `--time` flag to the command, the runner will run your code between `10` and `10.000` times (depending on execution time of first execution) and print the average execution time.

For example, running a benchmarked, optimized execution of day 1 would look like `cargo solve 1 --release --time`. Displayed _timings_ show the raw execution time of your solution without overhead like file reads.

#### Submitting solutions

> [!IMPORTANT]
> This command requires [installing the aoc-cli crate](#configure-aoc-cli-integration).

In order to submit part of a solution for checking, append the `--submit <part>` option to the `solve` command.

### Run all solutions

```sh
cargo all

# output:
#     Running `target/release/advent_of_code`
# ----------
# | Day 01 |
# ----------
# Part 1: 42 (19.0ns)
# Part 2: 42 (19.0ns)
# <...other days...>
# Total: 0.20ms
```

This runs all solutions sequentially and prints output to the command-line. Same as for the `solve` command, the `--release` flag runs an optimized build.

#### Update readme benchmarks

The template can output a table with solution times to your readme. In order to generate a benchmarking table, run `cargo all --release --time`. If everything goes well, the command will output "_Successfully updated README with benchmarks._" after the execution finishes and the readme will be updated.

Please note that these are not "scientific" benchmarks, understand them as a fun approximation. 😉 Timings, especially in the microseconds range, might change a bit between invocations.

### Run all tests

```sh
cargo test
```

To run tests for a specific day, append `--bin <day>`, e.g. `cargo test --bin 01`. You can further scope it down to a specific part, e.g. `cargo test --bin 01 part_one`.

### Format code

```sh
cargo fmt
```

### Lint code

```sh
cargo clippy
```

### Read puzzle description in terminal

> [!IMPORTANT]
> This command requires [installing the aoc-cli crate](#configure-aoc-cli-integration).

```sh
# example: `cargo read 1`
cargo read <day>

# output:
# Loaded session cookie from "/Users/<snip>/.adventofcode.session".
# Fetching puzzle for day 1, 2022...
# ...the input...
```

## Optional template features

### Configure aoc-cli integration

1. Install [`aoc-cli`](https://github.com/scarvalhojr/aoc-cli/) via cargo: `cargo install aoc-cli --version 0.12.0`
2. Create an `.adventofcode.session` file in your home directory and paste your session cookie. To retrieve the session cookie, press F12 anywhere on the Advent of Code website to open your browser developer tools. Look in _Cookies_ under the _Application_ or _Storage_ tab, and copy out the `session` cookie value. [^1]

Once installed, you can use the [download command](#download-input--description-for-a-day), the read command, and automatically submit solutions via the [`--submit` flag](#submitting-solutions).

### Check code formatting / clippy lints in CI

Uncomment the respective sections in the `ci.yml` workflow.

### Use VS Code to debug your code

1.  Install [rust-analyzer](https://marketplace.visualstudio.com/items?itemName=rust-lang.rust-analyzer) and [CodeLLDB](https://marketplace.visualstudio.com/items?itemName=vadimcn.vscode-lldb).
2.  Set breakpoints in your code. [^3]
3.  Click _Debug_ next to the unit test or the _main_ function. [^4]
4.  The debugger will halt your program at the specific line and allow you to inspect the local stack. [^5]

## Useful crates

-   [itertools](https://crates.io/crates/itertools): Extends iterators with extra methods and adaptors. Frequently useful for aoc puzzles.
-   [regex](https://crates.io/crates/regex): Official regular expressions implementation for Rust.

A curated list of popular crates can be found on [blessred.rs](https://blessed.rs/crates).

Do you have aoc-specific crate recommendations? [Share them!](https://github.com/fspoettel/advent-of-code-rust/edit/main/README.md)

## Common pitfalls

-   **Integer overflows:** This template uses 32-bit integers by default because it is generally faster - for example when packed in large arrays or structs - than using 64-bit integers everywhere. For some problems, solutions for real input might exceed 32-bit integer space. While this is checked and panics in `debug` mode, integers [wrap](https://doc.rust-lang.org/book/ch03-02-data-types.html#integer-overflow) in `release` mode, leading to wrong output when running your solution.

## Footnotes

[^1]: The session cookie might expire after a while (~1 month) which causes the downloads to fail. To fix this issue, refresh the `.adventofcode.session` file.
[^2]: The session cookie might expire after a while (~1 month) which causes the automated workflow to fail. To fix this issue, refresh the AOC_SESSION secret.
[^3]:
    <img src="https://user-images.githubusercontent.com/1682504/198838369-453dc22c-c645-4803-afe0-fc50d5a3f00c.png" alt="Set a breakpoint" width="450" />

[^4]:
    <img alt="Run debugger" src="https://user-images.githubusercontent.com/1682504/198838372-c89369f6-0d05-462e-a4c7-8cd97b0912e6.png" width="450" />

[^5]:
    <img alt="Inspect debugger state" src="https://user-images.githubusercontent.com/1682504/198838373-36df6996-23bf-4757-9335-0bc4c1db0276.png" width="450" />

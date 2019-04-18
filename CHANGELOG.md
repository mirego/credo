# Changelog

## 1.0.4

- Ignore heredocs in `RedundantBlankLines`
- Fix bug in `StringSigils`
- Minor refactorings

## 1.0.3

- Fix bug in `Name.full/1`
- Fix bug in `UI.truncate/2`
- Disable `LazyLogging` for Elixir >= 1.7
- Add UnnecessaryAliasExpansion check to experimental checks

## 1.0.2

- Fix false positive in `MapInto`
- Disable `MapInto` for Elixir 1.8 and higher
- Ensure issues are sorted by filename, line number and column number
- Warn about ineffective check filter patterns
- Add `ModuleDependencies` check to experimental checks

## 1.0.1

- Compilation warnings for Elixir 1.8
- Fix `StringSigils` to not crash with strings containing non-UTF8 characters

## 1.0.0

- Improve documentation
- Add error handling for malformed config files
- Write all warnings to `:stderr`
- Fix false positive for charlists in PipeChainStart
- Remove deprecated --one-line switch
- Deactivate checks `DuplicatedCode` and `DoubleBooleanNegation` by default

### BREAKING CHANGES

These changes concern people writing their own checks for Credo.

- `Credo.Check.CodeHelper` was removed. Please use the corresponding functions inside the `Credo.Code` namespace.

## 0.10.2

- Fix bug in AliasOrder

## 0.10.1

- Fixed "unnecessary atom quotes" compiler warning during analysis
- Handle timeouts when reading source files
- Ignore function calls for OperationOnSameValues
- Do not treat `|>` as an operator in SpaceAroundOperators
- Fix AliasOrder bug for multi alias statements
- Fix multiple false positives for SpaceAroundOperators
- ... and lots of important little fixes to issue messages, docs and the like!

## 0.10.0

- Switch `poison` for `jason`
- Add command-line switch to load a custom configuration file (`--config-file`)
- Add a debug report in HTML format when running Credo using `--debug`
- Add `node_modules/` to default file excludes
- Add `:ignore_urls` param for MaxLineLength
- Report violation for `not` as well as `!` in Refactor.NegatedConditionWithElse
- Fix false positive on LargeNumbers
- Fix NegatedConditionWithElse for `not/2` as well
- Disable PreferUnquotedAtoms for Elixir >= 1.7.0

### New checks

- Credo.Check.Refactor.MapInto

## 0.9.3

- Fix bug in Scope
- Fix false positive in MatchInConditionTest
- Fix false positive in UnusedEnumOperation
- Fix custom tasks by resolving config before validating it
- Add text support to `--min-priority` CLI switch (you can now set it to low/normal/high)

### New checks

- Credo.Check.Readability.AliasOrder

## 0.9.2

- Add `:ignore_comments` param to LongQuoteBlocks
- Fix false positive in UnusedPathOperation

## 0.9.1

- Fix false positive in SpaceAroundOperators
- Fix false positive in UnusedEnumOperation

## 0.9.0

- Add JSON support
- Ensure compatibility with Elixir 1.6
- Format codebase using Elixir 1.6 Formatter
- Rework internals in preparation of 1.0 release
- Credo now requires Elixir 1.4
- Include `test` directory in default config
- Add `excluded_argument_types` to PipeChainStart
- Emit warnings for non-existing checks, which are referenced in config
- Improve VariableNames
- ModuleDoc now raises an issue for empty strings in @moduledoc tags
- Fix bug on ModuleNames
- Fix false positive in VariableRebinding
- Fix false positive in SpaceAroundOperators
- Fix false positive on BoolOperationOnSameValues
- Fix false positive on SpaceAfterCommas
- Fix false positive on MaxLineLength
- Fix false positive in ParenthesesInCondition
- Remove `NameRedeclarationBy*` checks
- Remove support for @lint attributes

## 0.8.10

- Maintenance release

## 0.8.9

- Fix false positive in ParenthesesInCondition
- Fix Code.to_tokens/1 for Elixir 1.6
- Fix documentation for several checks

### New checks

- Credo.Check.Warning.ExpensiveEmptyEnumCheck

## 0.8.8

- Fix false positive for `LargeNumbers`
- Fix `SpaceAroundOperators` for @type module attributes
- Ignore def arguments and specs for `OperationOnSameValues`
- Fix crash in `ParenthesesOnZeroArityDefs` for variables named `defp`
- Fix false positives for `TagHelper`

## 0.8.7

- Fix false positive in `ModuleAttributeNames`
- Fix false positives in unused return checks
- Fix underlining in "list" action
- Fix CLI argument parsing for `mix credo.gen.check`
- Fix loading of custom checks
- Prevent error when run against empty umbrella projects
- Prevent output for tests

## 0.8.6

- Fix false positive in SpaceAfterCommas
- Fix false positive in SpaceAroundOperators
- Fix bug with extracting explain command args
- Allow anonymous functions to be piped as raw values

## 0.8.5

- Speed up scope counting in CLI summary

## 0.8.4

- Remove `CheckForUpdates` for good
- Fix `RaiseInsideRescue` for implicit try

## 0.8.3

- Do not run `CheckForUpdates` on CI systems and in editor integrations

## 0.8.2

- Refactor all consistency checks, providing a nice speed improvement (thx @little-bobby-tables)
- Improve Elixir 1.5 compatibility

## 0.8.1

- Fix misleading issue message for `LongQuoteBlocks`

## 0.8.0

- Load source files in parallel
- Improve high memory consumption
- Fix comment handling of Charlists, Sigils and Strings
- `LazyLogging` now only checks for `debug` calls by default
- Add `--mute-exit-status` CLI switch, which mutes Credo's exit status (this will be used for integration tests as it means that any non-zero exit status results from a runtime error of Credo)
- Add default param values to `mix explain` output
- `TagTODO` and `TagFIXME` now also report tags from doc-related module attributes (`@doc`, `@moduledoc`, `@shortdoc`)
- Fix false positives for `TrailingWhiteSpace`
- Fix compiler warnings for `Sigils`

### BREAKING CHANGES

These changes concern people writing their own checks for Credo.

- `Credo.SourceFile` struct was refactored: `source`, `lines` and `ast` are now stored in ETS tables.
- `Credo.Config` struct was replaced by `Credo.Execution`.
- `run/3` callbacks for `Credo.Check` are now `run/4` callbacks as they have to receive the execution's `Credo.Execution` struct.

### Config Comments replace `@lint` attributes

`@lint` attributes are deprecated and will be removed in Credo `0.9.0` because
they are causing a compiler warning in Elixir `>= 1.4`.

Users of Credo can now disable individual lines or files for all or just
specific checks.

For now, config comments let you exclude individual files completely

    # credo:disable-for-this-file
    defmodule SomeApp.ThirdPartyCode do
    end

or deactivate specific lines:

    def my_fun do
      # credo:disable-for-next-line
      IO.inspect :this_is_actually_okay
    end

or add the check module to exclude just that one check:

    def my_fun do
      # credo:disable-for-next-line Credo.Check.Warning.IoInspect
      IO.inspect :this_is_actually_okay
    end

or use a Regex to be more flexible which checks to exclude:

    def my_fun do
      # credo:disable-for-next-line /IoInspect/
      IO.inspect :this_is_actually_okay
    end

Here's a list with the syntax options:

* `# credo:disable-for-this-file` - to disable for the entire file
* `# credo:disable-for-next-line` - to disable for the next line
* `# credo:disable-for-previous-line` - to disable for the previous line
* `# credo:disable-for-lines:<count>` - to disable for the given number of lines (negative for previous lines)

### New checks

- Credo.Check.Refactor.LongQuoteBlocks

## 0.7.4

-	Fix false positives in SpacesAroundOperators
- Fix `--all` CLI switch
- Always enforce `strict` mode for `<filename>:<line_no>`
- Improve docs on checks
- Disable `MultiAliasImportRequireUse` by default

### Disabled checks

- Credo.Check.Consistency.MultiAliasImportRequireUse

## 0.7.3

- Fix filename annotation when using `--read-from-stdin`
- Fix filename handling on Windows
- Fix consistency checks triggered by contents of sigils
- Fix consistency checks triggered by contents of charlists

### New check

- Credo.Check.Warning.LazyLogging

## 0.7.2

- Fix `@lint` attribute deprecation hint
- Fix filename handling bug for Windows
- Fix flycheck formatting
- Add param to ignore strings/heredocs in `TrailingWhiteSpace`

### New check

- Credo.Check.Readability.SpaceAfterCommas

## 0.7.1

- Fix `--config_name`CLI switch
- Fix `UI.wrap_at/2` for Unicode strings
- Fix false positive for `ModuleNames`

## 0.7.0

- Added deprecation hint about `@lint` attributes
- Fixed file inclusion/exclusion bug
- Fixed false positives in `SpaceAroundOperators`
- Deprecated `NameRedeclarationBy*` checks
- Fixed false positives in `PipeChainStart`
- Changed `AppendSingleItem`'s priority and make it opt-in
- Renamed `NoParenthesesWhenZeroArity` to `ParenthesesOnZeroArityDefs`
- Fixed a bug in `ParenthesesOnZeroArityDefs`

### Added/deprecated checks

- Credo.Check.Warning.MapGetUnsafePass
- Credo.Check.Refactor.AppendSingleItem
- Credo.Check.Readability.Semicolons

Switched some checks to opt-in by default

- Credo.Check.Readability.Specs
- Credo.Check.Refactor.ABCSize
- Credo.Check.Refactor.VariableRebinding
- Credo.Check.Warning.MapGetUnsafePass
- Credo.Check.Warning.NameRedeclarationByAssignment
- Credo.Check.Warning.NameRedeclarationByCase
- Credo.Check.Warning.NameRedeclarationByDef
- Credo.Check.Warning.NameRedeclarationByFn


## 0.6.1

- Fixed false positives for `StringSigils` in heredocs
- Fixed a bug in `SourceFile.column`

## 0.6.0

- Do not warn about ParenthesesInCondition in one-line `if` call
- Add `--no-strict` CLI switch
- Fixed exit status for `mix credo list`
- Fixed exclusion of checks set to `low` priority

### New Checks

- consistency/multi_alias_import_require_use
- readability/no_parentheses_when_zero_arity
- readability/redundant_blank_lines
- readability/single_pipe
- readability/specs
- readability/string_sigils
- refactor/double_boolean_negation
- refactor/variable_rebinding

## 0.5.3

- Fix crash in CheckForUpdates

## 0.5.2

- Add ability to specify `strict` in `.credo.exs` config file
- Add `no_case?` to variable name checks
- Add `Module.name` utility method
- Fix bug in NameRedeclarationByDef
- Fix bug in LargeNumbers

## 0.5.1

- Use Hex.pm API to retrieve update information for Credo

## 0.5.0

- See below

## 0.4.14

- Fix compiler error due to usage of undocumented Hex APIs (sorry)

## 0.4.13

- Prevent crashing when parsing non-UTF-8 source files
- Fix yet another issue with finding sources
- Fix false positives for PipeChainStart
- Fix false positives for AbcSize
- Remove dead code
- Update deps

## 0.4.12

- Prevent ModuleDoc from checking nested modules for ignored modules
- Fix issue with ParenthesesInCondition
- Fix issue with PipChainStart
- Fix issue with reading from stdin
- Log errors to stderr

## 0.4.11

- Fix compatibility issues with Elixir < 1.2
- Fix yet another issue with finding sources

## 0.4.10

- Fix another issue with finding sources

## 0.4.9

- Fix issues with finding sources
- Don't enforce @moduledoc requirement for Mixfile or Test modules

## 0.4.8

- Add `exclude_functions` option to `PipeChainStart`
- No longer report issues in case of ambiguous aliases in `AliasUsage`
- Fix false positives for `LargeNumbers` in Elixir `>= 1.3.2` (again)
- Lots of refactorings

## 0.4.7

- Ignore module attributes like `@spec` in `AliasUsage`
- Improve source file loading

## 0.4.6

- Add `ignore_specs` option to `MaxLineLength`
- Fix false positives for `LargeNumbers` in Elixir `>= 1.3.2`
- Fix compiler warnings in preparation for Elixir v1.4

## 0.4.5

- Warnings about redeclaring names of Kernel or local functions now only consider function of arity zero.
- Warnings for operations with constant result now ignore division by 1
- Better explanation how to configure checks in `explain` output

## 0.4.4

- New check: readability/parentheses_in_condition

## 0.4.3

- Fix compatibility issues in `Credo.CLI.Command.GenCheck` for Elixir < 1.2

## 0.4.2

- Fix outdated comments regarding .credo.exs in README
- Fix name generator including "Lib." prefix for custom checks

## 0.4.1

- Maintenance release because I apparently don't understand how merging works :sweat:

## 0.4.0

### Custom check support

- Adds support for custom checks in your projects.

  Using two new mix commands `mix credo.gen.config` and `mix credo.gen.check`
  you can generate the boilerplate to include custom checks in your projects.

### BREAKING CHANGE: Checks listed in `.credo.exs`

- Prior to `v0.4.0`, `.credo.exs` contained the full list of checks specific to your project
- Starting with `v0.4.0` the check list in `credo.exs` will be merged with the standard check list, with your definitions overwriting the defaults
- PRO: you can customize individual tasks to your liking and still benefit from additional standard checks with each new release
- CON: this means checks have to be disabled explicitly in `.credo.exs`

### New Checks

- readability/large_numbers
- warning/bool_operation_on_same_values
- warning/unused_file_operation
- warning/unused_path_operation
- warning/unused_regex_operation

### Minor Improvements

- Ready for Elixir 1.3
- Checks for new Credo versions automatically, like Hex does (can be disabled)
- Umbrella apps work out of the box now
- DuplicatedCode can now ignore macro calls
- ModuleDoc now ignores modules declaring exceptions
- ModuleDoc now allows modules to be ignored based on their name
- MatchInCondition now allows "simple" wildcard assignments in conditionals
- Checks analysing all files in the codebase sequentially (consistency checks)
  are now run in parallel
- If `--only` is given, all issues are shown (`mix credo --only MaxLineLength`
  previously yielded no results, since all issues needed `--strict` to actually
  be displayed)

## 0.3.13

- Fix false positives for `NameRedeclarationByDef`.
- Fix false positives for `UnusedEnumOperation`.

## 0.3.12

- Fix false positives for `SpaceInParentheses`.
- Fix false positive for `SpaceAroundOperators`.

## 0.3.11

- Fix a bug with checks on function names when declaring a variable with the name `def`, `defp` or `defmacro`.

## 0.3.10

- Fix a bug resulting in `UnicodeConversionError` for code containing UTF-8 comments.

## 0.3.9

- Fix a bug in `AliasUsage`.

## 0.3.8

- Fix false positives for `AliasUsage`.

## 0.3.7

- Fix false positive for `SpaceAroundOperators`.

## 0.3.6

- Fix false positives for `SpaceAroundOperators` and `PipeChainStart`.
- Add option to read from STDIN for better editor integration

## 0.3.5

- Remove superfluous call to `IO.inspect`.
- Update deps requirements to make HexFaktor happy.

## 0.3.4

- Fix false positives for `SpaceAroundOperators` in binary pattern matches.
- Fix a bug when supplying a single file via the CLI.

## 0.3.3

- Fix false positives for `SpaceAroundOperators` and `SpaceInParentheses`.

## 0.3.2

- `mix do credo, <something-else>` was broken and never ran `<something-else>`, even if `credo` succeeded (exited with exit status 0). Now it runs `<something-else>` as long as `credo` succeeds.

## 0.3.1

- Fix compiler warnings
- Improve copywriting for consistency checks (thx @vdaniuk)

## 0.3.0

### Per-function lint support

- Adds support for `@lint` attributes used to configure linting for specific
  functions.

  For now, this lets you exclude functions completely

      @lint false
      def my_fun do
      end

  or deactivate specific checks *with the same syntax used in the config file*:

      @lint {Credo.Check.Design.TagTODO, false}
      def my_fun do
      end

  or use a Regex instead of the check module to exclude multiple checks at once:

      @lint {~r/Refactor/, false}
      def my_fun do
      end

  Finally, you can supply multiple tuples as a list and combine the above:

      @lint [{Credo.Check.Design.TagTODO, false}, {~r/Refactor/, false}]
      def my_fun do
      end

### New Checks

- consistency/space_around_operators
- consistency/space_in_parentheses

### Minor Improvements

- Add `--format` CLI switch
- Include experimental Flycheck support via `--format=flycheck`
- **Deprecate** `--one-line` CLI switch, use `--format=oneline` instead
- Add convenience alias `--ignore` for `--ignore-checks`
- Fix colors for terminals with light backgrounds (thx @lucasmazza)

## 0.2.6

- Fix false positives for UnusedEnumOperation checks (thx @kbaird)

## 0.2.5

- Fix error occuring when a project has exactly one `defexception` module
- Change the tag for Refactoring Opportunities from "[R]" to "[F]" (thx @rranelli)

## 0.2.4

- Remove unused alias to avoid warning during compilation

## 0.2.3

- Improves docs and UI wording (thx @crack and @jessejanderson)

## 0.2.2

- Adds a missing word to the output of the `categories` command (thx @bakkdoor)

## 0.2.1

- Fixes a problem with CaseTrivialMatches crashing

## 0.2.0

### Error Status

Credo now fails with an exit status != 0 if it shows any issues. This will enable usage of Credo inside CI systems/build chains.

The exit status of each check is customizable and exit statuses of all
encountered checks are collected, uniqued and summed:

    issues
    |> Enum.map(&(&1.exit_status))
    |> Enum.uniq
    |> Enum.reduce(0, &(&1+&2))

This way you can reason
about the encountered issues right from the exit status.

Default values for the checks are based on their category:

    consistency:  1
    design:       2
    readability:  4
    refactor:     8
    warning:     16

So an exit status of 12 tells you that you have only Readability Issues and Refactoring Opportunities, but e.g. no Warnings.

### New Checks

- readability/module_doc
- refactor/case_trivial_matches
- refactor/cond_statements
- refactor/function_arity
- refactor/match_in_condition
- refactor/pipe_chain_start
- warning/operation_with_constant_result
- warning/unused_enum_operation
- warning/unused_keyword_operation
- warning/unused_list_operation
- warning/unused_tuple_operation

### Minor Improvements

- There are two new aliases for command line switches:
  - you can use `--only` as alias for `--checks`
  - you can use `--strict` as alias for `--all-priorities`
- `mix credo --only <checkname>` will always display a full list of results
  (you no longer need to specify `--all` separately)
- `mix credo explain <file:line_number>` now also explains the available configuration parameters for the issue/check
- The ExceptionNames check no longer fails if only a single exception module is found (#22).

## 0.1.10

- Apply many fixes in anticipation of Elixir v1.2 (thx @c-rack)
- Improve docs
- Wrap long issue descriptions in `suggest` command

## 0.1.9

- Add missing `-A` alias for `--all-priorities`
- Improve wording in the CLI a bit

## 0.1.8

- Add `apps/` to default directories

## 0.1.7

- Bugfix to `NameRedeclarationBy\*` checks
- `Sources.exclude` had a bug when excluding directories

## 0.1.6

- Rename CLI switch `--pedantic` to `--all-priorities` (alias is `-A`)
- Fix a bug in SourceFile.column (#7)
- Improve README section about basic usage, commands and issues

## 0.1.1 - 0.1.5

Multiple Hex releases due to the fact that I apparently don't understand how deps compilation works :sweat:

## 0.1.0

Initial release

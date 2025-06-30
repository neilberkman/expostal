# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.1] - 2025-01-XX

### Added
- GitHub Actions CI workflow replacing Travis CI
- Support for Elixir 1.15+ and Erlang/OTP 25+
- .tool-versions file for asdf version management
- .formatter.exs for code formatting configuration
- Enhanced documentation with installation instructions for different platforms
- Contributing guidelines in README
- Requirements section in documentation

### Changed
- **BREAKING**: Minimum Elixir version requirement updated from ~> 1.4 to ~> 1.15
- **BREAKING**: Minimum Erlang/OTP version requirement updated to 25+
- Updated ex_doc dependency from ~> 0.14 to ~> 0.34
- Updated dialyxir dependency from ~> 0.5 to ~> 1.4
- Modernized mix.exs configuration format
- Updated README badges from Travis CI to GitHub Actions
- Enhanced .gitignore with modern patterns
- Improved code examples in README with proper syntax highlighting

### Removed
- Travis CI configuration (.travis.yml)
- Travis provisioning script (.provision.travis.sh)
- Legacy build configuration options in mix.exs

### Fixed
- Modernized project structure to follow current Elixir conventions
- Updated dependencies to address security and compatibility issues

## [0.2.0] - Previous Release
- Original functionality for parsing and expanding addresses using libpostal
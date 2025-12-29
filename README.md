# ![Elixir](https://hexdocs.pm/ex_unit/assets/logo.png) expostal

[![CI](https://github.com/neilberkman/expostal/actions/workflows/ci.yml/badge.svg)](https://github.com/neilberkman/expostal/actions/workflows/ci.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/expostal.svg)](https://hex.pm/packages/expostal)
[![Documentation](https://img.shields.io/badge/docs-hexpm-blue.svg)](https://hexdocs.pm/expostal)
[![License](https://img.shields.io/github/license/neilberkman/expostal.svg)](https://github.com/neilberkman/expostal/blob/master/LICENSE)

Elixir binding for [Libpostal] - a library for parsing/normalizing street addresses around the world.
Powered by statistical NLP and open geo data.

**This is a modernized fork of [SweetIQ/expostal](https://github.com/SweetIQ/expostal)** with precompiled NIFs, comprehensive test coverage, and modern tooling.

## Installation

The package can be installed by adding `expostal` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:expostal, "~> 0.3.0"}]
end
```

### Precompiled NIFs

**New in 0.3.0!** This package now includes precompiled NIFs for:

- Linux x86_64
- macOS ARM64 (Apple Silicon)
- macOS x86_64 (Intel)

For these platforms, you can install without needing a C compiler or libpostal development headers.

### System Dependencies

You still need libpostal installed on your system at runtime:

#### macOS

```bash
# Install libpostal using Homebrew
brew install libpostal
```

#### Ubuntu/Debian

```bash
# Install dependencies
sudo apt-get install curl autoconf automake libtool pkg-config

# Build and install libpostal
git clone https://github.com/openvenues/libpostal
cd libpostal
./bootstrap.sh
./configure --datadir=$(pwd)/data
make -j4
sudo make install
sudo ldconfig  # Linux only
```

[Libpostal]: https://github.com/openvenues/libpostal

## Usage

Parsing an address:

```elixir
iex> Expostal.parse_address("615 Rene Levesque Ouest, Montreal, QC, Canada")

%{city: "montreal", country: "canada", house_number: "615",
  road: "rene levesque ouest", state: "qc"}
```

Expanding an address:

```elixir
iex> Expostal.expand_address("781 Franklin Ave Crown Hts Brooklyn NY")

["781 franklin avenue crown heights brooklyn new york",
  "781 franklin avenue crown heights brooklyn ny"]
```

## What's New in 0.3.0

- **Precompiled NIFs** for Linux x86_64, macOS ARM64, and macOS x86_64
- **Modern tooling**: Credo, Dialyzer, Quokka, ExCoveralls
- **Comprehensive test suite** with edge cases and error handling
- **GitHub Actions CI/CD** with test matrix for Elixir 1.15-1.18 and OTP 25-28
- **Improved documentation** and better error messages
- All code quality checks passing

## Requirements

- Elixir 1.15-1.18
- Erlang/OTP 25-28
- libpostal (system-wide installation required)

## Documentation

View the docs on [https://hexdocs.pm/expostal](https://hexdocs.pm/expostal), or
generate the docs locally with `mix docs`.

## Development

```bash
# Install dependencies
mix deps.get

# Compile with warnings as errors
mix compile --warnings-as-errors

# Run tests
mix test

# Check code quality
mix credo --strict

# Run type checker
mix dialyzer

# Format code
mix format
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Credits

Original project by [SweetIQ/expostal](https://github.com/SweetIQ/expostal).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

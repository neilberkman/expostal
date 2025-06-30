# ![Elixir](https://hexdocs.pm/ex_unit/assets/logo.png) expostal

[![CI](https://github.com/SweetIQ/expostal/actions/workflows/ci.yml/badge.svg)](https://github.com/SweetIQ/expostal/actions/workflows/ci.yml)
[![Hex.pm](https://img.shields.io/hexpm/v/expostal.svg)](https://hex.pm/packages/expostal)
[![Documentation](https://img.shields.io/badge/docs-hexpm-blue.svg)](https://hexdocs.pm/expostal)
[![License](https://img.shields.io/github/license/sweetiq/expostal.svg)](https://github.com/SweetIQ/expostal/blob/master/LICENSE)

Elixir binding for [Libpostal] - a library for parsing/normalizing street addresses around the world. 
Powered by statistical NLP and open geo data.

Tutorial on how to write Elixir/Erlang NIF: http://cs.mcgill.ca/~mxia3/2017/06/18/tutorial-extending-elixir-with-c-using-NIF/

## Installation

The package can be installed by adding `expostal` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:expostal, "~> 0.2.1"}]
end
```

### Dependencies

Depends on [system-wide installation of libpostal](https://github.com/openvenues/libpostal#installation).

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

## Requirements

- Elixir 1.15+
- Erlang/OTP 25+
- libpostal (system-wide installation required)

## Documentation

View the docs on [https://hexdocs.pm/expostal](https://hexdocs.pm/expostal), or
generate the docs locally with `mix docs`.

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

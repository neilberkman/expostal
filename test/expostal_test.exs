defmodule ExpostalTest do
  use ExUnit.Case
  doctest Expostal

  describe "parse_address/1" do
    test "parses Canadian address with full components" do
      address = "615 Rene Levesque Ouest, Montreal, QC, Canada"
      parsed = Expostal.parse_address(address)

      assert parsed == %{
               country: "canada",
               city: "montreal",
               house_number: "615",
               road: "rene levesque ouest",
               state: "qc"
             }
    end

    test "parses French Canadian address" do
      address = "92 rue de l'Église, QC"
      parsed = Expostal.parse_address(address)

      assert parsed == %{
               house_number: "92",
               road: "rue de l'église",
               state: "qc"
             }
    end

    test "parses Chinese address" do
      address = "天津市红桥区一号路一百号"
      parsed = Expostal.parse_address(address)

      assert parsed == %{
               city: "天津市红桥区",
               road: "一号路",
               house_number: "一百号"
             }
    end

    test "parses US address with zip code" do
      address = "1600 Pennsylvania Avenue NW, Washington, DC 20500"
      parsed = Expostal.parse_address(address)
      assert parsed.house_number == "1600"
      assert parsed.road == "pennsylvania avenue nw"
      assert parsed.city == "washington"
      assert parsed.state == "dc"
      assert parsed.postcode == "20500"
    end

    test "parses UK address" do
      address = "10 Downing Street, London SW1A 2AA, UK"
      parsed = Expostal.parse_address(address)
      assert parsed.house_number == "10"
      assert parsed.road == "downing street"
      assert parsed.city == "london"
    end

    test "parses address with apartment number" do
      address = "123 Main St Apt 4B, New York, NY 10001"
      parsed = Expostal.parse_address(address)
      assert parsed.house_number == "123"
      assert parsed.road == "main st"
    end

    test "handles empty string" do
      parsed = Expostal.parse_address("")
      assert is_map(parsed)
    end

    test "handles address with only street name" do
      address = "Main Street"
      parsed = Expostal.parse_address(address)
      IO.inspect(parsed, label: "Main Street parsed")
      assert is_map(parsed)
      assert Map.has_key?(parsed, :road) or parsed == %{}
    end
  end

  describe "expand_address/1" do
    test "expands US address abbreviations" do
      assert address_in_expansion(
               "781 Franklin Ave Crown Hts Brooklyn NY",
               "781 franklin avenue crown heights brooklyn new york"
             )
    end

    test "expands German address" do
      expansions = Expostal.expand_address("Friedrichstraße 128, Berlin, Germany")
      IO.inspect(expansions, label: "German address expansions")

      assert address_in_expansion(
               "Friedrichstraße 128, Berlin, Germany",
               "friedrich straße 128 berlin germany"
             )
    end

    test "expands street abbreviations" do
      assert address_in_expansion("MAPLE ST.", "maple street")
    end

    test "expands directional abbreviations" do
      assert address_in_expansion("123 N Main St", "123 north main street")
    end

    test "returns list for all addresses" do
      expansions = Expostal.expand_address("1 Main St")
      assert is_list(expansions)
      assert expansions != []
    end

    test "handles empty string" do
      expansions = Expostal.expand_address("")
      assert is_list(expansions)
    end

    test "normalizes case" do
      expansions = Expostal.expand_address("BROADWAY")
      assert Enum.all?(expansions, &(String.downcase(&1) == &1))
    end
  end

  describe "bootstrap/0" do
    test "can be called successfully" do
      assert :ok == Expostal.bootstrap()
    end

    test "can be called multiple times" do
      assert :ok == Expostal.bootstrap()
      assert :ok == Expostal.bootstrap()
    end
  end

  defp address_in_expansion(original, expanded) do
    Enum.member?(Expostal.expand_address(original), expanded)
  end
end

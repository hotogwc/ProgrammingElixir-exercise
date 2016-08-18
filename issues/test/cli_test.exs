defmodule CliTest do
  use ExUnit.Case
  doctest Issues

  import Issues.CLI, only: [parse_args: 1, sort_into_ascending_order: 1]

  test ":help returned by options parsing with -h or --help options" do
    assert parse_args(["-h", "anything"]) == :help
    assert parse_args(["--help", "anything"]) == :help
  end

  test "three values returned if three given" do
    assert parse_args(["user", "project", "99"]) == {"user", "project", 99}
  end

  test "count is default if two values given" do
    assert parse_args(["user", "project"])  == {"user", "project", 4}
  end

  test "sort ascending order the correct way" do
    result = sort_into_ascending_order(created_fake_list(["c", "a", "b"]))
    issues = for issue <- result, do: Map.get(issue, "created_at")
    assert issues = ~w{a b c}
  end

  defp created_fake_list(values) do
    for value <- values, do: %{"created_at" => value, "otherdata" => "xxx"}
  end


 
end

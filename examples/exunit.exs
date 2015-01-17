ExUnit.start

defmodule MathTest do
  use ExUnit.Case, async: true

  test "adding two numbers" do
    assert 1 + 2 == 4
  end
end
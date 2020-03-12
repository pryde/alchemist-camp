defmodule AlchemistTail do
  @moduledoc """
  Documentation for `AlchemistTail`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AlchemistTail.hello()
      :world

  """
  def start(parsed, file, invalid) do
    body = read_file(file)
    flags = Enum.into parsed, %{}
    print_n_lines(body, flags.lines)
  end

  def read_file(filename) do
    File.read!(filename)
  end

  def print_n_lines(text, n) do
    lines = String.split(text, ~r/(\r\n|\r|\n)/)
    last_n = Enum.take(lines, -n)
    Enum.map(last_n, fn line -> IO.puts(line) end)
  end
end

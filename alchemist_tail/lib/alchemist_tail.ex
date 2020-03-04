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

    case Enum.count(parsed) do
      0   -> print_n_lines(body, 10)
      _   -> print_n_lines(body, elem(parsed, 1))
    end
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

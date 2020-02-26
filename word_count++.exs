input = IO.gets("Enter a file name from which to count (-h for help):\n")
    |> String.trim

if input == "-h" do
    IO.puts """
        Usage: [filename] -[flags]
        Flags
        -l      displays line count
        -c      displays character count
        -w      displays word count (default)
        Multiple flags may be used. Example usage to display line and character count:

        somefile.txt -lc

        """
else
    args = String.split(input, "-")
    filename = List.first(args) |> String.trim
    flags = case Enum.at(args, 1) do
        nil -> ["w"]
        chars -> String.split(chars, "") |> Enum.filter(fn x -> x != "" end)
    end

    body = File.read! filename
    lines = String.split(body, ~r{(\r\n|\n|\r)})        # fucking magic: carriage return, newline, return
    words = String.split(body, ~r{(\\n|[^\w])+})
        |> Enum.filter(fn x -> x != "" end)             # more fucking magic: see word_count.exs
    chars = String.split(body, "")
        |> Enum.filter(fn x -> x != "" end)

    Enum.each(flags, fn flag ->
        case flag do
            "l" -> IO.puts "Lines: #{Enum.count(lines)}"
            "w" -> IO.puts "Words: #{Enum.count(words)}"
            "c" -> IO.puts "Chars: #{Enum.count(chars)}"
            _   -> nil
        end
    end)
end
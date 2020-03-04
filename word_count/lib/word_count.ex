defmodule WordCount do
   def start(parsed, file, invalid) do
        if (invalid != []) or (file == "h") do
            show_help()
        else
            read_file(parsed, file)
        end
    end

    def show_help() do
        IO.puts """
        Usage: [filename] -[flags]
        Flags
        -l      displays line count
        -c      displays character count
        -w      displays word count (default)
        Multiple flags may be used.
        """
    end

    def read_file(parsed, filename) do
        flags = case Enum.count(parsed) do
            0       -> [:words]
            _       -> Enum.map(parsed, &(elem(&1, 0)))
        end

        IO.inspect flags
        body = File.read! filename
        lines = String.split(body, ~r/(\r\n|\r|\n)/)
        words =
          String.split(body, ~r/(\\n|[^\w'])+/)
          |> Enum.filter(fn x -> x != "" end)
        chars = String.split(body, "") |> Enum.filter(fn x -> x != "" end)

        Enum.each(flags, fn flag ->
          case flag do
            :lines    -> IO.puts "Lines: #{Enum.count(lines)}"
            :words    -> IO.puts "Words: #{Enum.count(words)}"
            :chars    -> IO.puts "Chars: #{Enum.count(chars)}"
          end
        end)
    end
end

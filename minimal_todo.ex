defmodule MinimalTodo do
    def start do
        # ask user for file name
        # open and read file
        # parse data
        # ask user for command
        # (read, add, delete, load file, save file)
        filename = IO.gets("Name of .csv to load\n") |> String.trim
        read(filename)
            |> parse
            |> get_command
    end

    def get_command(data) do
        prompt = "Type the first letter of the command you want to run\n"
            <> "R)ead Todos    L)oad a .csv    A)dd a Todo    D)elete a Todo    S)ave a .csv\n"
        
        command = IO.gets(prompt)
            |> String.trim
            |> String.downcase

        case command do
            "r"     -> show_todos(data)
            "d"     -> delete_todos(data)
            "q"     -> "Goodbye!"
            _       -> get_command(data)
        end
    end

    def delete_todos(data) do
        todo = IO.gets("Which Todo would you like to delete?\n") |> String.trim
        if Map.has_key? data, todo do
            IO.puts "Ok."
            new_map = Map.drop(data, [todo])
            IO.puts ~s("#{todo}" has been deleted.)
            get_command(new_map)
        else
            IO.puts ~s(There is no Todo named "#{todo}".)
            show_todos(data, false)
            delete_todos(data)
        end
    end

    def read(filename) do
        case File.read(filename) do
            {:ok, body}         -> body
            {:error, reason}    -> IO.puts ~s(Could not open file "#{filename}"\n)
                                   IO.puts ~s("#{:file.format_error reason}"\n)
                                   start()
        end
    end

    def parse(body) do
        [header | lines] = String.split(body, ~r{(\r\n|\r|\n)})
        titles = tl String.split(header, ",") #|> Enum.filter(fn x -> x != "" end)
        parse_lines(lines, titles)
    end

    def parse_lines(lines, titles) do
        Enum.reduce(lines, %{}, fn line, built ->
            [name | fields] = String.split(line, ",") #|> Enum.filter(fn x -> x != "" end)
            if Enum.count(fields) == Enum.count(titles) do
                line_data = Enum.zip(titles, fields) |> Enum.into(%{})
                Map.merge(built, %{name => line_data})
            else
                built
            end
        end)
    end

    def show_todos(data, next_command? \\ true) do
        items = Map.keys data
        IO.puts "You have the following Todos:\n"
        Enum.each(items, fn item -> IO.puts item end)
        IO.puts "\n"
        if next_command? do
            get_command(data)
        end
    end
end
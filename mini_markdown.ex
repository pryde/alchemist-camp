defmodule MiniMarkdown do
    def to_html(text) do
        text 
            |> bold
            |> italics
            |> h2
            |> h1
            |> big
            |> small
            |> p
            |> save
    end

    def read_markdown() do
        filename = IO.gets("Markdown file to parse: ") |> String.trim

        case File.read(filename) do
            {:ok, body} -> to_html(body)
            {:error, _} -> IO.puts ~s(Error reading "#{filename}")
        end
    end

    def save(text) do
        case File.write("out.html", text) do
            :ok -> IO.puts ~s(Saved parsed markdown to "out.html")
            {:error, _} -> IO.puts ~s(Error saving parsed markdown)
        end
    end

    def big(text) do
        Regex.replace(~r/\+\+(.*)\+\+/, text, "<big>\\1</big>")
    end

    def bold(text) do
        Regex.replace(~r/\*\*(.*)\*\*/, text, "<strong>\\1</strong>")
    end

    def h1(text) do
        Regex.replace(~r/(# )(.*)(\r\n|\r|\n|$)/, text, "<h1>\\2</h1>")
    end

    def h2(text) do
        Regex.replace(~r/(## )(.*)(\r\n|\r|\n|$)/, text, "<h2>\\2</h2>")
    end

    def italics(text) do
        Regex.replace(~r/\*(.*)\*/, text, "<em>\\1</em>")
    end

    def p(text) do
        Regex.replace(~r/(\r\n|\r|\n|^)+([^\r\n]+)((\r\n|\r|\n)$)?/, text, "<p>\\2</p>")
    end

    def small(text) do
        Regex.replace(~r/--(.*)--/, text, "<small>\\1</small>")
    end
    
    def test_str do
        """
        # Heading    
        ## Heading 2

        stuff ++big stuff++ --small stuff--

        *This* is a **test** string for working with MiniMarkdown.

        Hopefully, *every*thing works as expected.

        Fingers crossed.
        """
    end
end
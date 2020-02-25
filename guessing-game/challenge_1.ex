# have user enter their name, then greet them by name
# if they enter your name, do something special
defmodule FirstChallenge do
    def greet do
        name = IO.gets("Hello, what's your name?\n")
        case String.trim(name) do
            "Chase" -> "What an excellent name, my creator's name is Chase!"
            _ -> "Nice to meet you, #{String.trim(name)}!"
        end
    end
end
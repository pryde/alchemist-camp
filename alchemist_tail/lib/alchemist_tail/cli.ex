defmodule AlchemistTail.CLI do
    def main(args) do
        {parsed, args, invalid} = OptionParser.parse(
            args,
            switches: [lines: nil],
            aliases: [n: :lines]
        )

        AlchemistTail.start(parsed, args, invalid)
    end
end
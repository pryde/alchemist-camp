defmodule Fibonacci do
   def time(func, arg) do
        t0 = Time.utc_now
        func.(arg)
        Time.diff(Time.utc_now, t0, :millisecond)
    end
    
    def compare(n \\ 45) do
        IO.puts "Naive: #{time(&naive_fib_n/1, n)}\nTail: #{time(&tail_fib_n/1, n)}"
    end
    
    def naive_fib_n(n) do
        case n do
            0 -> 0
            1 -> 1
            2 -> 1
            _ -> naive_fib_n(n - 1) + naive_fib_n(n - 2)
        end
    end

    def tail_fib_n(n) when n < 0, do: -1
    def tail_fib_n(n), do: tail_fib_n(n, 0, 1)
    def tail_fib_n(1, _acc1, acc2), do: acc2
    def tail_fib_n(n, acc1, acc2) do
        tail_fib_n(n - 1, acc2, acc1 + acc2)
    end
end

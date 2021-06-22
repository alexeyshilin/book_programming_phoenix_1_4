
defmodule InfoSys.Counter do
  use GenServer

  def inc(pid), do: GenServer.cast(pid, :inc) 

  def dec(pid), do: GenServer.cast(pid, :dec)

  def val(pid) do 
    GenServer.call(pid, :val)
  end

  def start_link(initial_val) do
    GenServer.start_link(__MODULE__, initial_val) 
  end

  def init(initial_val) do
    Process.send_after(self(), :tick, 1000)
    {:ok, initial_val}
  end

  def handle_info(:tick, val) when val <= 0, do: raise "boom!"

  def handle_info(:tick, val) do
    IO.puts("tick #{val}")
    Process.send_after(self(), :tick, 1000)
    {:noreply, val - 1}
  end

  def handle_cast(:inc, val) do 
    {:noreply, val + 1}
  end

  def handle_cast(:dec, val) do 
    {:noreply, val - 1}
  end

  def handle_call(:val, _from, val) do 
    {:reply, val, val}
  end
end

# iex -S mix
# iex> alias InfoSys.Counter
# iex> {:ok, counter} = Counter.start_link(10)
# iex> Counter.inc(counter)
# iex> Counter.inc(counter)
# iex> Counter.val(counter)
# iex> Counter.dec(counter)
# iex> Counter.val(counter)

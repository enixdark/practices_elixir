require IEx
defmodule Meter.Worker do
  use GenServer

  @name MW

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: MW])
  end

  def init(_) do
    {:ok, %{}}
  end


  def handle_call({:location, location}, _from, state) do
    result = url_for(location) 
             |> HTTPoison.get 
             |> parse_response_of
    case result do
      {:ok, temp} ->
        new_stats = update_stats(state, location)
        {:reply, "#{location}: #{temp}*C", new_stats}
      :error ->
        {:reply, :error, state} 
    end
  end

  def handle_call(:get_stats, _from ,state) do
    {:reply, state, state}
  end

  def handle_cast(:reset_stats, _state), do: {:noreply, %{}}
  def handle_cast(:stop, state), do: {:stop, :normal, state}

  def handle_info(msg, state) do
    IO.puts "received #{inspect msg}"
    {:noreply, state}
  end
  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  def terminate(reason ,state) do
    IO.puts "server terminated because of #{inspect reason}"
    inspect state
    :ok
  end





  def reset_stats(pid) do
    GenServer.cast(pid, :reset_stats)
  end

  def get_stats(pid) do
    GenServer.call(pid, :get_stats)
  end

  defp update_stats(states, location) do
    IEx.pry
    case Map.has_key?(states, location) do
       true ->
         Map.update!(states, location, &(&1 + 1))
       false ->
         Map.put_new(states, location, 1)
    end
  end
  def temperature_of(pid, location) do
    GenServer.call(pid, {:location, location})
  end

  defp url_for(location) do
    location = URI.encode(location)
    "http://api.openweathermap.org/data/2.5/weather?q=#{location}&appid=#{apikey}"
  end

  defp parse_response_of({:ok, %HTTPoison.Response{body: body, status_code: 200}}) do
    body |> JSON.decode!
         |> compute_temperature
  end

  defp parse_response_of(_) do
    :error
  end

  defp compute_temperature(json) do
    try do
      temp = (json["main"]["temp"] - 273.15) |> Float.round(1)
      {:ok, temp}
    rescue
      _ -> :error
    end
  end

  defp apikey do
    "cde3c00f149aaa131ed81e31aba6fc60"
  end
end









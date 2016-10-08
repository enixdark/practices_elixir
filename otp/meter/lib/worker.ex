  defmodule Meter.Worker do


    def loop do
      
      receive do
        {sender_pid, location} ->
          send(sender_pid, {:ok, temperature_of(location)})
        _ ->
          IO.puts "don't have process"
      end
      loop
    end
    
    def temperature_of(location) do
      result = url_for(location) 
               |> HTTPoison.get 
               |> parse_response_of
      case result do
        {:ok, temp} ->
          "#{location}: #{temp}*C"
        :error ->
        "#{location} not found"
    end
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









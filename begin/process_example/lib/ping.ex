defmodule Ping do
	def start do
		loop
	end

	def loop do
		receive do
			{:pong, pid} ->
				send pid, {:ping, self}
			{_, pid} ->
				send pid, {:error, self}
			
		end
		loop
	end
end
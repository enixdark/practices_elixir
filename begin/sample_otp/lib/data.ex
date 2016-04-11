defmodule Data do
	use GenEvent.Behaviour

	def init(data) do
		{:ok, data}
	end
	def get(pid) do
		:gen_event.call(pid, __MODULE__, :get)
	end

	def plus(pid, value) do
		:gen_event.call(pid, __MODULE__, {:plus, value})
	end

	def sub(pid, value) do
		:gen_event.call(pid, __MODULE__, {:sub, value})
	end

	def handle_event(state, data) do
		case state do
			{:plus, value }-> {:ok, data + value}
			{:set, value } -> {:ok, value}
			{:sub, value }-> {:ok, data - value}
		end
	end

	def handle_call(state, data) do
		case state do
		  :get -> {:ok, data, data}
		end
	end
end
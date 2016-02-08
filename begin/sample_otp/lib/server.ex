defmodule Server do
	# use GenServer.Behaviour

	def start_link(items) do
		:gen_server.start_link(Server, items, [])
	end

	def init(items) do
		{:ok, items}
	end

	def store(pid, item) do
		:gen_server.call(pid, {:store, item})
	end

	def take(pid, item) do
		:gen_server.call(pid, {:take, item})
	end


	def handle_call({:store, item}, _from, items) do
		{:reply, :ok, [item|items]}
	end

	def handle_call({:take, item}, _from, items) do
		case Enum.member?(items, item) do
			true -> {:reply, {:ok, item}, List.delete(items,item)}
			false -> {:reply, :not_found, items}
		end
	end
end
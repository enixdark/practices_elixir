defmodule Svisor do
	use Supervisor.Behaviour

	def start_link do
		result = {:ok, sup} = :supervisor.start_link(__MODULE__, [])
		start_workers(sup)
		result
	end

	def start_workers(sup) do
		{:ok, data} = :supervisor.start_child(sup, worker(SListData, []))
		:supervisor.start_child(sup, worker(SListSub, [data]))
	end

	def init(_) do
		# child_p = [worker(SList,list)]
		supervise([], strategy: :one_for_one)
	end
end

defmodule SListSub do
	use Supervisor.Behaviour

	def start_link(pid) do
		:supervisor.start_link(__MODULE__, pid)
	end

	def init(list) do
		child_p = [worker(SListServer, [list])]
		supervise(child_p, strategy: :one_for_one)
	end
end


defmodule SListData do
	use GenServer.Behaviour

	def start_link do
		:gen_server.start_link(__MODULE__, [], [])
	end

	def init(list) do
		{:ok, list}
	end

	def save_state(pid, state) do
		:gen_server.cast pid, {:save_state, state}
	end

	def get_state(pid) do
		:gen_server.call pid, :get_state
	end

	def handle_call(:get_state, _from, current_state) do
		{:reply, current_state, current_state}
	end

	def handle_cast({:save_state, state}, _current_state) do
		{:noreply, state}
	end

end

defmodule SListServer do
	use GenServer.Behaviour

	def init(pid) do
		items = SListData.get_state(pid)
		{:ok, {items, pid}}
	end

	def start_link(pid) do
		:gen_server.start_link({:local,:list}, __MODULE__,pid, [])
	end
	

	def clear do
		:gen_server.cast(:list, :clear)
	end

	def getItems do
		:gen_server.call(:list, :gets)
	end

	def append(item) do
		:gen_server.cast(:list, {:append, item})
	end

	def remove(item) do
		:gen_server.cast(:list, {:remove, item})
	end

	def crash do
		:gen_server.call(:list, :crash)
	end

	def handle_cast(state, {items, pid}) do
		case state do
		  :clear -> {:noreply, {[],pid}}
		  {:append, item} -> {:noreply, {items ++ [item], pid}}
		  {:remove, item} -> {:noreply, {List.delete(items, item),pid}}
		end
	end

	def handle_call(state, _from, {items,pid}) do
		case state do
		  :gets -> {:reply, items, {items ,pid}}
		  :crash -> 1 == 2
		end
	end

	def terminate(_reason, {items, pid}) do
		SListData.save_state(pid,items)
	end
end
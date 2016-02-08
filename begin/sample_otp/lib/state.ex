defmodule State do
	def start_link do
		{:ok, pid} = :gen_fsm.start_link(__MODULE__, [], [])
		pid
	end

	def one(fsm) do
		:gen_fsm.sync_send_event(fsm, :one)
	end

	def two(fsm) do
		:gen_fsm.sync_send_event(fsm, :two)
	end

	def three(fsm) do
		:gen_fsm.sync_send_event(fsm, :three)
	end

	def init(_) do
		{:ok, :starting, []} 
	end

	

	def starting(key, _from, state_data) do
		case key  do
		  :one -> {:reply, :one, :starting, state_data}
		  :two -> {:reply, :two, :starting, state_data}
		  :three -> {:reply, :three, :starting, state_data}
		  _ -> {:reply, :starting, :starting, state_data}
		end
	end

	
end
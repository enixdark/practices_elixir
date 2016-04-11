defmodule Event do
	def init do
		:gen_event.start_link
	end

	def add(pid, data, args) do
		:gen_event.add_handler(pid, data, args)
	end

	def notify(pid, event) do
		:gen_event.notify(pid, event)
	end
end
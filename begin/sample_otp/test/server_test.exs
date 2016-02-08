defmodule ServerTest do
	use ExUnit.Case
	require Server
	# @pid nil
	# setup do
	# 	{:ok, @pid} = Server.start_link([])
	# end

	test "simple test with genserver" do
		{:ok, pid} = Server.start_link([])
		assert :ok == Server.store(pid, :key)
	end

	test "with remove something" do
		{:ok, pid} = Server.start_link([])
		:gen_server.call(pid, {:store, :key})
		assert {:ok, :key} == Server.take(pid, :key)
	end

	test "with key that haven't in data" do
		{:ok, pid} = Server.start_link([])
		assert :not_found == Server.take(pid, :key)
	end
end
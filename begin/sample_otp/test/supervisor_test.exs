defmodule SupervisorTest do
	use ExUnit.Case
	setup do
		SListServer.start_link []
		SListServer.clear
	end

	test "return empty when start gen server" do
		assert SListServer.getItems  == []
	end


	test "some data append into server" do
		SListServer.append(:Python)
		SListServer.append(:Erlang)
		SListServer.append(:Rust)
		assert SListServer.getItems  == [:Python,:Erlang,:Rust]
		SListServer.remove(:Python)
		assert SListServer.getItems  == [:Erlang,:Rust]

	end
end
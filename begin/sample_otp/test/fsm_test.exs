defmodule FSMTest do
	
	use ExUnit.Case


	test "start with default state in fsm" do
		fsm = State.start_link
		assert State.one(fsm) == :one
	end

	test "next state" do
		fsm = State.start_link
		assert State.two(fsm) == :two
		# assert State.three(fsm) == :three
	end
end
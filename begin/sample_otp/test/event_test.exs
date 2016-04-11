defmodule EventTest do
	use ExUnit.Case

	test "init event" do
		{:ok, event} = Event.init
		Event.add(event, Data,3)
		assert Data.get(event) == 3
		Event.notify(event, {:plus, 3})
		assert Data.get(event) == 6
		Event.notify(event, {:set, 10})
		Event.notify(event, {:sub, 10})
		assert Data.get(event) == 0
	end
end
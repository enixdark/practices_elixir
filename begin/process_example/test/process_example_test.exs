defmodule ProcessExampleTest do
  use ExUnit.Case
  require Ping
  test "the truth" do
    assert 1 + 1 == 2
  end

  test "process with actor model" do
  	ping = spawn_link(Ping, :start, [])
  	send ping, {:pong, self}
  	assert_receive {:ping, ping}
  end

  test "process with actor model more than twice" do
  	ping = spawn_link(Ping, :start, [])
  	send ping, {:pong, self}
  	assert_receive {:ping, ping}
  	send ping, {:pong, self}
  	assert_receive {:ping, ping}
  end
end

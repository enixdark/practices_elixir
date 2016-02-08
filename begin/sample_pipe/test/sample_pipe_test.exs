defmodule SamplePipeTest do
  use ExUnit.Case

  test "simple pipe with ls " do
  	output = """
		sample_pipe_test.exs
		test_helper.exs
  	"""
  	assert Pipe.ls == output
  end

  test "simple pipe with grep" do
  	output = """
		sample_pipe_test.exs
		test_helper.exs
  	"""
  	assert Pipe.grep(output,"sample") ==  ["sample_pipe_test.exs"]
  end

  test "simple pipe with awk" do
  	input = ["action adventure", "horror", "comedy", "drama"]
  	output =  ["action", "horror", "comedy", "drama"]
  	assert Pipe.awk(input,1) ==  output
  end

  test "with pipeline" do
  	assert (Pipe.ls |> Pipe.grep("sample")) == ["sample_pipe_test.exs"]
  end
end

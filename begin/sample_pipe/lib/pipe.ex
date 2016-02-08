defmodule Pipe do
	def ls do
		"""
		sample_pipe_test.exs
		test_helper.exs
  		"""
	end

	def grep(text, search) do
		# Enum.filter(
		# 	String.split(text, "\n"),
		# 	fn(word) -> Regex.match?(~r/#{search}/ , word) end
		# )
		String.split(text, "\n") |> Enum.filter(
			&(Regex.match?(~r/#{search}/ , &1))
		)
	end

	def awk(lines, column) do
		Enum.map( lines, 
			fn(line) -> 
				String.strip(line) 
				|> (&Regex.split(~r/ /, &1 , trim: true)).()
				|> Enum.at(column - 1)
		end)
	end
end
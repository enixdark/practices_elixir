Dynamo.under_test(Simpleweb.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule Amnesia.Test do
	def start do
		:error_logger.tty(false)
		Amnesia.Schema.create
		Amnesia.start

		:ok
	end

	def stop do
		Amnesia.stop
		Amnesia.Schema.destroy

		:error_logger.tty(true)
		:ok
	end
end

defmodule Simpleweb.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end

Code.require_file "test_helper.exs", __FILE__

use Amnesia

defdatabase Simpleweb.Database do
	deftable Simple, [:id, :content, :in_reply_to_id], type: :ordered_set do
		@type t :: Simple[id: integer, content: String.t, in_reply_to_id: integer ]
	end
end

defmodule AmnesiaTest do
	use ExUnit.Case
	use Simpleweb.Database

	setup_all do
		Amnesia.Test.start
	end

	teardown_all do
		Amnesia.Test.stop
	end

	setup do
		Simple.Database.create!
	end

	test "saving simple web" do
		Amnesia.transaction! do
			s = Simple[id: 1, content: "hello world" ]
			s.write
		end

		assert "hello world" == Simple.read!(1).content
	end


	test  "finding replies" do
		Amnesia.transaction! do
			s = Simple[id: 1, content: "hello world" ]
			s.write
			reply = Simple[id: 2, content: "hello world", in_reply_to_id: 1]
			reply.write
		end

		Amnesia.transaction! do
			assert "hello world" == Simple.read!(2).in_reply_to.content
			[reply] = Simple.read!(1).replies
			assert 'hello world' == reply.content
		end
	end
end


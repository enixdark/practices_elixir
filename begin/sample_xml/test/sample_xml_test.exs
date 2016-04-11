#load record from erlang core
defmodule R do
  require Record
  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText, Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlNamespace, Record.extract(:xmlNamespace, from_lib: "xmerl/include/xmerl.hrl")

end
defmodule SampleXmlTest do
  use ExUnit.Case
  import R
  doctest SampleXml

  

  @data """
	<html>
		<head>
			<title>XML</title>
		</head>
		<body>
			<div class="e1">A</div>
			<div class="e2">B</div>
		</body>
	</html>
  	"""
  test "parse xml" do
    { xml, _ } = :xmerl_scan.string(:erlang.bitstring_to_list(@data))
    [ titleE ] = :xmerl_xpath.string('/html/head/title', xml)
    
    [ text ] = titleE |> xmlElement(:content)
    title = text |> xmlText(:value)
    assert title == 'XML'
  end


end

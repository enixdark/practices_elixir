defmodule PlateWebWeb.Schema.Query.MenuItemsTest do
  use PlateWebWeb.ConnCase, async: true

  setup do
    PlateWeb.Seeds.run()
  end

  @query """
  {
    menuItems {
      name
    }
  }
  """

  test "menuItems field returns menu items" do
    conn = build_conn()
    conn = get conn, "/api", query: @query

    assert json_response(conn, 200) == %{
      "data" =>
        %{"menuItems" => [
            %{"name" => "Bánh mì"},
            %{"name" => "Chocolate Milkshake"},
            %{"name" => "Croque Monsieur"},
            %{"name" => "French Fries"},
            %{"name" => "Lemonade"},
            %{"name" => "Masala Chai"},
            %{"name" => "Muffuletta"},
            %{"name" => "Papadum"},
            %{"name" => "Pasta Salad"},
            %{"name" => "Reuben"},
            %{"name" => "Soft Drink"},
            %{"name" => "Vada Pav"},
            %{"name" => "Vanilla Milkshake"},
            %{"name" => "Water"}
          ]
        }
    }
  end

  @query """
  {
    menuItems(matching: "reu") {
      name
    }
  }
  """

  test "menuItems field returns menu items filtered by name" do
    response = get(build_conn(), "/api", query: @query)
    assert json_response(response, 200) == %{
      "data" => %{
        "menuItems" => [
        %{"name" => "Reuben"},
        ]
      }
    }
  end

  @query """
  {
    menuItems(matching: 123) {
      name
    }
  }
  """

  test "menuItems field returns errors when using a bad value" do
    response = get(build_conn(), "/api", query: @query)
    %{"errors" => [%{"message" => message}]} = json_response(response, 400)
    assert message == "Argument \"matching\" has invalid value 123."
  end


  @query """
  query ($term: String) {
    menuItems(matching: $term) {
      name
    }
  }
  """

  @variables %{"term" => "reu"}
  test "menuItems field filters by name when using a variable" do
    response = get(build_conn(), "/api", query: @query, variables: @variables)
    assert json_response(response, 200) == %{
      "data" => %{
        "menuItems" => [
        %{"name" => "Reuben"},
        ]
      }
    }

  end

  @query """
  {
    menuItems(order: DESC) {
      name
    }
  }
  """

  test "menuItems field returns items descending using literals" do
    response = get(build_conn(), "/api", query: @query)
    assert %{
      "data" => %{"menuItems" => [%{"name" => "Water"} | _]}
    } = json_response(response, 200)
  end

  @query """
  query ($order: SortOrder!) {
    menuItems(order: $order) {
      name
    }
  }
  """
  @variables %{"order" => "DESC"}
    test "menuItems field returns items descending using variables" do
    response = get(build_conn(), "/api", query: @query, variables: @variables)
    assert %{
    "data" => %{"menuItems" => [%{"name" => "Water"} | _]}
    } = json_response(response, 200)
  end

  @query """
  {
    menuItems(filter: {category: "Sandwiches", tag: "Vegetarian"}) {
      name
    }
  }
  """

  test "menuItems field returns menuItems, filtering with a literal" do
    response = get(build_conn(), "/api", query: @query)
    assert %{
      "data" => %{"menuItems" => [%{"name" => "Vada Pav"}]}
    } == json_response(response, 200)
  end

  @query """
  query($filter: MenuItemFilter!) {
    menuItems(filter: $filter) {
      name
    }
  }
  """

  @variables %{filter: %{"tag" => "Vegetarian", "category" => "Sandwiches"}}
  test "menuItems field returns menuItems, filtering with a variable" do
    response = get(build_conn(), "/api", query: @query, variables: @variables)
    assert %{
      "data" => %{"menuItems" => [%{"name" => "Vada Pav"}]}
    } == json_response(response, 200)
  end
end

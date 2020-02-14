defmodule DagUtilsTest do
  use ExUnit.Case
  doctest DagUtils

  @moduledoc """
  The DAG used for testing is:

  B   C   D
   \ / \
    F   E
    \  / \
     G    A
  """

  @dag %{
    "A" => [],
    "B" => ["F"],
    "C" => ["E", "F"],
    "D" => [],
    "E" => ["A", "G"],
    "F" => ["G"],
    "G" => []
  }

  @expected_A_internal []
  @expected_A_leafs []
  @expected_A_all @expected_A_internal ++ @expected_A_leafs

  @expected_B_internal ["F"]
  @expected_B_leafs ["G"]
  @expected_B_all @expected_B_internal ++ @expected_B_leafs

  @expected_C_internal ["E", "F"]
  @expected_C_leafs ["A", "G"]
  @expected_C_all @expected_C_internal ++ @expected_C_leafs

  @expected_D_internal []
  @expected_D_leafs []
  @expected_D_all @expected_D_internal ++ @expected_D_leafs

  @expected_E_internal []
  @expected_E_leafs ["A", "G"]
  @expected_E_all @expected_E_internal ++ @expected_E_leafs

  @expected_F_internal []
  @expected_F_leafs ["G"]
  @expected_F_all @expected_F_internal ++ @expected_F_leafs

  @expected_G_internal []
  @expected_G_leafs []
  @expected_G_all @expected_G_internal ++ @expected_G_leafs

  defp shuffled_dag(adjacency_list) do
    Enum.reduce(adjacency_list, %{}, fn {parent_id, children}, acc ->
      Map.put(acc, parent_id, Enum.shuffle(children))
    end)
  end

  describe "get_internal_and_leaf_reachable_nodes" do
    test "computation is correct" do
      dag = shuffled_dag(@dag)
      %{
        "A" => {computed_A_internal, computed_A_leafs},
        "B" => {computed_B_internal, computed_B_leafs},
        "C" => {computed_C_internal, computed_C_leafs},
        "D" => {computed_D_internal, computed_D_leafs},
        "E" => {computed_E_internal, computed_E_leafs},
        "F" => {computed_F_internal, computed_F_leafs},
        "G" => {computed_G_internal, computed_G_leafs}
      } = DagUtils.get_internal_and_leaf_reachable_nodes(dag)

      assert Enum.sort(@expected_A_internal) == Enum.sort(computed_A_internal)
      assert Enum.sort(@expected_A_leafs) == Enum.sort(computed_A_leafs)

      assert Enum.sort(@expected_B_internal) == Enum.sort(computed_B_internal)
      assert Enum.sort(@expected_B_leafs) == Enum.sort(computed_B_leafs)

      assert Enum.sort(@expected_C_internal) == Enum.sort(computed_C_internal)
      assert Enum.sort(@expected_C_leafs) == Enum.sort(computed_C_leafs)

      assert Enum.sort(@expected_D_internal) == Enum.sort(computed_D_internal)
      assert Enum.sort(@expected_D_leafs) == Enum.sort(computed_D_leafs)

      assert Enum.sort(@expected_E_internal) == Enum.sort(computed_E_internal)
      assert Enum.sort(@expected_E_leafs) == Enum.sort(computed_E_leafs)

      assert Enum.sort(@expected_F_internal) == Enum.sort(computed_F_internal)
      assert Enum.sort(@expected_F_leafs) == Enum.sort(computed_F_leafs)

      assert Enum.sort(@expected_G_internal) == Enum.sort(computed_G_internal)
      assert Enum.sort(@expected_G_leafs) == Enum.sort(computed_G_leafs)
    end
  end

  describe "get_reachable_nodes" do
    test "computation is correct" do
      dag = shuffled_dag(@dag)
      %{
        "A" => computed_A_all,
        "B" => computed_B_all,
        "C" => computed_C_all,
        "D" => computed_D_all,
        "E" => computed_E_all,
        "F" => computed_F_all,
        "G" => computed_G_all
      } = DagUtils.get_reachable_nodes(dag)

      assert Enum.sort(@expected_A_all) == Enum.sort(computed_A_all)

      assert Enum.sort(@expected_B_all) == Enum.sort(computed_B_all)

      assert Enum.sort(@expected_C_all) == Enum.sort(computed_C_all)

      assert Enum.sort(@expected_D_all) == Enum.sort(computed_D_all)

      assert Enum.sort(@expected_E_all) == Enum.sort(computed_E_all)

      assert Enum.sort(@expected_F_all) == Enum.sort(computed_F_all)

      assert Enum.sort(@expected_G_all) == Enum.sort(computed_G_all)
    end
  end
end

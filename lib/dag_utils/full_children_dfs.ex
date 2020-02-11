defmodule DagUtils.FullChildrenDfs do
  # Leaf node
  def enriched_with_subgraph(dag_computed, _adjacency_list, node_id, _direct_children = []) do
    Map.put(dag_computed, node_id, {[], []})
  end

  # Internal node
  def enriched_with_subgraph(dag_computed, adjacency_list, node_id, direct_children) do
    # Enrich computed children with every child's computation
    dag_computed = direct_children
    |> Enum.reduce(dag_computed, fn child_id, new_dag_computed ->
      enriched_with_subgraph(new_dag_computed, adjacency_list, child_id, Map.get(adjacency_list, child_id))
    end)

    # Compute current node's tuple
    reduced_tuple = direct_children
    |> Enum.map(fn child_id -> {child_id, Map.get(dag_computed, child_id)} end)
    |> Enum.reduce({[], []}, &reduce_children_tuples/2)

    # Add tuple to dag_computed
    Map.put(dag_computed, node_id, reduced_tuple)
  end

  # Leaf node
  defp reduce_children_tuples({child_id, {[], []}}, {current_internal, current_leaves}) do
    {
      # New internal = current internal
      current_internal,
      # New leaves: current leaves + child node
      [child_id | current_leaves] |> Enum.uniq
    }
  end

  # Internal node
  defp reduce_children_tuples({child_id, {child_internal, child_leaves}}, {current_internal, current_leaves}) do
    {
      # New internal = current internal + child node + child node's internal nodes
      [child_id | current_internal] ++ child_internal
      |> Enum.uniq,

      # New leaves = current leaves + child node's leaves
      current_leaves ++ child_leaves
      |> Enum.uniq
    }
  end
end

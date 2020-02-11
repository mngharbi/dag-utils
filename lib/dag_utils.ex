defmodule DagUtils do
  @type node_id :: atom() | String.t()
  @type node_list :: list(node_id)
  @type adjacency_list :: %{required(node_id()) => node_list()}

  @doc """
  Get internal and leaf children for all nodes

  ### Example
  ```
  get_internal_and_leaf_nodes(%{
    "ID1" => ["ID2"],
    "ID2" => []
  })
  > %{
    "ID1" => {[], ["ID2"]},
    "ID2" => {[], []},
  }
  ```
  """
  @spec get_internal_and_leaf_nodes(adjacency_list()) :: {node_list, node_list}
  def get_internal_and_leaf_nodes(adjacency_list) do
    Enum.reduce(adjacency_list, %{}, fn {node_id, direct_children}, dag_computed ->
      case Map.has_key?(dag_computed, node_id) do
        # Already computed
        true ->
          dag_computed

        # Not computed yet
        false ->
          DagUtils.FullChildrenDfs.enriched_with_subgraph(dag_computed, adjacency_list, node_id, direct_children)
      end
    end)
  end

end

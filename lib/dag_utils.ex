defmodule DagUtils do
  @type node_id :: atom() | String.t()
  @type node_list :: list(node_id)
  @type adjacency_list :: %{required(node_id()) => node_list()}

  @doc """
  Get internal and leaf reachable nodes for all nodes

  ### Example
  ```
  get_internal_and_leaf_reachable_nodes(%{
    "ID1" => ["ID2"],
    "ID2" => []
  })
  > %{
    "ID1" => {[], ["ID2"]},
    "ID2" => {[], []},
  }
  ```
  """
  @spec get_internal_and_leaf_reachable_nodes(adjacency_list()) :: %{required(node_id()) => {node_list, node_list}}
  def get_internal_and_leaf_reachable_nodes(adjacency_list) do
    DagUtils.LeafAndInternalDfs.compute(adjacency_list)
  end

  @doc """
  Get all descendents for all nodes

  ### Example
  ```
  get_internal_and_leaf_nodes(%{
    "ID1" => ["ID2"],
    "ID2" => []
  })
  > %{
    "ID1" => ["ID2"],
    "ID2" => [],
  }
  ```
  """
  @spec get_reachable_nodes(adjacency_list()) :: %{required(node_id()) => node_list}
  def get_reachable_nodes(adjacency_list) do
    DagUtils.DescendentsDfs.compute(adjacency_list)
  end

end

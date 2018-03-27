defmodule Api.Resolvers.Workouts do
  def all(parent, %{by_name: query}, resolution) do
    {:ok, Core.Workouts.by_name(query)}
  end

  def all(parent, %{}, resolution) do
    {:ok, Core.Workouts.all()}
  end
end

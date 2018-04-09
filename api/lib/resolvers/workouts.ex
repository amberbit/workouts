defmodule Api.Resolvers.Workouts do
  def all(_parent, %{by_name: query}, _resolution) do
    {:ok, Core.Workouts.by_name(query)}
  end

  def all(_parent, %{}, _resolution) do
    {:ok, Core.Workouts.all()}
  end

  def create(_parent, args, _resolution) do
    {:ok, Core.Workouts.create(args)}
  end
end

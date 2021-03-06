defmodule Api.Schema do
  use Absinthe.Schema

  import_types(Api.Schema.Types)

  alias Api.Resolvers

  query do
    @desc "Get all workouts"
    field :workouts, list_of(:workout) do
      arg(:by_name, :string)

      resolve(&Resolvers.Workouts.all/3)
    end
  end
end

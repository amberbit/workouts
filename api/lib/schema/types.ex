defmodule Api.Schema.Types do
  use Absinthe.Schema.Notation

  object :exercise do
    field(:id, :id)
    field(:name, :string)
  end

  object :set do
    field(:id, :id)
    field(:exercise, :exercise)
    field(:reps, :integer)
  end

  object :workout do
    field(:id, :id)
    field(:name, :string)
    field(:sets, list_of(:set))
  end

  input_object :set_input do
    field(:exercise, non_null(:exercise))
    field(:reps, non_null(:integer))
  end
end

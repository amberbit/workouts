defmodule Core.Workout do
  defstruct [:id, :name, :sets]
end

defmodule Core.Set do
  defstruct [:id, :exercise, :reps]
end

defmodule Core.Exercise do
  defstruct [:id, :name]
end

defmodule Core.Workouts do
  def all do
    [
      %Core.Workout{
        id: 1,
        name: "Day 1: Legs",
        sets: [
          %Core.Set{id: 1, exercise: %Core.Exercise{id: 1, name: "Barbell squat"}, reps: 8},
          %Core.Set{id: 2, exercise: %Core.Exercise{id: 1, name: "Barbell squat"}, reps: 8},
          %Core.Set{id: 3, exercise: %Core.Exercise{id: 1, name: "Barbell squat"}, reps: 8},
          %Core.Set{id: 4, exercise: %Core.Exercise{id: 1, name: "Stiff-leg deadlift"}, reps: 10},
          %Core.Set{id: 5, exercise: %Core.Exercise{id: 1, name: "Stiff-leg deadlift"}, reps: 10},
          %Core.Set{id: 6, exercise: %Core.Exercise{id: 1, name: "Stiff-leg deadlift"}, reps: 10},
          %Core.Set{id: 7, exercise: %Core.Exercise{id: 1, name: "Barbell calf raise"}, reps: 10},
          %Core.Set{id: 8, exercise: %Core.Exercise{id: 1, name: "Barbell calf raise"}, reps: 10},
          %Core.Set{id: 9, exercise: %Core.Exercise{id: 1, name: "Barbell calf raise"}, reps: 10}
        ]
      }
    ]
  end

  def by_name(name_fragment) do
    all
    |> Enum.filter(& String.contains?(&1.name, name_fragment))
  end
end

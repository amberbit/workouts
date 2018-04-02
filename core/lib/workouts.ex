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
          %Core.Set{id: 2, exercise: %Core.Exercise{id: 2, name: "Barbell squat"}, reps: 8},
          %Core.Set{id: 3, exercise: %Core.Exercise{id: 3, name: "Barbell squat"}, reps: 8},
          %Core.Set{id: 4, exercise: %Core.Exercise{id: 4, name: "Stiff-leg deadlift"}, reps: 10},
          %Core.Set{id: 5, exercise: %Core.Exercise{id: 5, name: "Stiff-leg deadlift"}, reps: 10},
          %Core.Set{id: 6, exercise: %Core.Exercise{id: 6, name: "Stiff-leg deadlift"}, reps: 10},
          %Core.Set{id: 7, exercise: %Core.Exercise{id: 7, name: "Barbell calf raise"}, reps: 10},
          %Core.Set{id: 8, exercise: %Core.Exercise{id: 8, name: "Barbell calf raise"}, reps: 10},
          %Core.Set{id: 9, exercise: %Core.Exercise{id: 9, name: "Barbell calf raise"}, reps: 10}
        ]
      },
    %Core.Workout{
        id: 2,
        name: "Day 2: Chest",
        sets: [
          %Core.Set{id: 10, exercise: %Core.Exercise{id: 10, name: "Push ups"}, reps: 4},
          %Core.Set{id: 11, exercise: %Core.Exercise{id: 11, name: "Push ups"}, reps: 4},
          %Core.Set{id: 12, exercise: %Core.Exercise{id: 12, name: "Push ups"}, reps: 4},
          %Core.Set{id: 13, exercise: %Core.Exercise{id: 13, name: "Bench press"}, reps: 5},
          %Core.Set{id: 14, exercise: %Core.Exercise{id: 14, name: "Bench press"}, reps: 5},
          %Core.Set{id: 15, exercise: %Core.Exercise{id: 15, name: "Bench press"}, reps: 5},
        ]
      }
    ]
  end

  def by_name(name_fragment) do
    all
    |> Enum.filter(&String.contains?(parsed(&1.name), parsed(name_fragment)))
  end

  defp parsed(string) do
    String.downcase(string)
  end
end

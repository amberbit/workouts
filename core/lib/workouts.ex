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
  use GenServer

  def init(workouts) do
    {:ok, workouts}
  end

  def start_link() do
    GenServer.start_link(__MODULE__, seed(), name: __MODULE__)
  end

  def handle_call(:all, _from, workouts) do
    {:reply, workouts, workouts}
  end

  def handle_call({:create, args}, _from, workouts) do
    args =
      args
      |> Map.put(:id, gen_id(workouts))
      |> Map.put(:sets, write_sets(Map.get(args, :sets), workouts))

    workout = struct(Core.Workout, args)
    {:reply, workout, [workout | workouts]}
  end

  def all() do
    GenServer.call(__MODULE__, :all)
  end

  def by_name(name_fragment) do
    all()
    |> Enum.filter(&String.contains?(parsed(&1.name), parsed(name_fragment)))
  end

  def create(args) do
    GenServer.call(__MODULE__, {:create, args})
  end

  defp parsed(string) do
    String.downcase(string)
  end

  defp gen_id(collection) do
    Enum.max_by(collection, fn collection -> collection.id end).id + 1
  end

  defp write_sets(sets, workouts) do
    sets |> Enum.with_index() |> Enum.map(fn {set, idx} -> write_set(set, idx, workouts) end)
  end

  defp write_set(set, idx, workouts) do
    set |> Map.put(:id, gen_set_id(workouts, idx))
  end

  defp gen_set_id(workouts, idx) do
    workouts |> Enum.flat_map(fn workout -> workout.sets end) |> gen_id |> Kernel.+(idx)
  end

  defp seed do
    [
      %Core.Workout{
        id: 1,
        name: "Day 1: Legs",
        sets: [
          %Core.Set{id: 1, exercise: %Core.Exercise{id: 1, name: "Barbell squat"}, reps: 8},
          %Core.Set{id: 2, exercise: %Core.Exercise{id: 1, name: "Barbell squat"}, reps: 8},
          %Core.Set{id: 3, exercise: %Core.Exercise{id: 1, name: "Barbell squat"}, reps: 8},
          %Core.Set{id: 4, exercise: %Core.Exercise{id: 2, name: "Stiff-leg deadlift"}, reps: 10},
          %Core.Set{id: 5, exercise: %Core.Exercise{id: 2, name: "Stiff-leg deadlift"}, reps: 10},
          %Core.Set{id: 6, exercise: %Core.Exercise{id: 2, name: "Stiff-leg deadlift"}, reps: 10},
          %Core.Set{id: 7, exercise: %Core.Exercise{id: 3, name: "Barbell calf raise"}, reps: 10},
          %Core.Set{id: 8, exercise: %Core.Exercise{id: 3, name: "Barbell calf raise"}, reps: 10},
          %Core.Set{id: 9, exercise: %Core.Exercise{id: 3, name: "Barbell calf raise"}, reps: 10}
        ]
      },
      %Core.Workout{
        id: 2,
        name: "Day 2: Chest",
        sets: [
          %Core.Set{id: 10, exercise: %Core.Exercise{id: 4, name: "Push ups"}, reps: 4},
          %Core.Set{id: 11, exercise: %Core.Exercise{id: 4, name: "Push ups"}, reps: 4},
          %Core.Set{id: 12, exercise: %Core.Exercise{id: 4, name: "Push ups"}, reps: 4},
          %Core.Set{id: 13, exercise: %Core.Exercise{id: 5, name: "Bench press"}, reps: 5},
          %Core.Set{id: 14, exercise: %Core.Exercise{id: 5, name: "Bench press"}, reps: 5},
          %Core.Set{id: 15, exercise: %Core.Exercise{id: 5, name: "Bench press"}, reps: 5}
        ]
      }
    ]
  end
end

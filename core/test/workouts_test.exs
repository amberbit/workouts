defmodule Core.WorkoutsTest do
  use ExUnit.Case, async: true
  alias Core.Workouts

  describe "all/0" do
    test "gets the list of all workouts" do
      workouts = Workouts.all()
      assert is_list(workouts)

      [workout | _] = workouts

      assert workout.name == "Day 1: Legs"
      assert is_list(workout.sets)

      [set | _] = workout.sets

      assert set.reps == 8
      assert set.exercise.name == "Barbell squat"
    end
  end
end

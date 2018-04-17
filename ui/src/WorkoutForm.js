import React, { Component } from 'react';
import { Mutation } from 'react-apollo';

import { WorkoutsQuery, AddWorkoutQuery } from './queries';

const Exercises = [
  { id: 1, name: 'Barbell squat' },
  { id: 2, name: 'Stiff-leg deadlift' },
  { id: 3, name: 'Barbell calf raise' },
  { id: 4, name: 'Push ups' },
  { id: 5, name: 'Bench press' },
];

class WorkoutFormView extends Component {
  constructor(){
    super();
    this.initialState = {
      name: '',
      sets: [{ exercise: {}, reps: 1 }],
    };
    this.state = { ...this.initialState };
    this.renderExericseLine = this.renderExericseLine.bind(this);
  }

  handleSubmit(e, Workout) {
    e.preventDefault();
    const { name, sets } = this.state;
    const parsedSets = sets.map(set => ({
      reps: parseInt(set.reps),
      exercise:
        typeof set.exercise === "string"
          ? JSON.parse(set.exercise)
          : set.exercise
    }));

    Workout({ variables: { name, sets: parsedSets } });
  }

  handleUpdate(
    cache,
    {
      data: { create_workout: workout }
    }
  ) {
    const { workouts } = cache.readQuery({
      query: WorkoutsQuery,
      variables: { filter: "" }
    });
    cache.writeQuery({
      query: WorkoutsQuery,
      data: { workouts: [workout, ...workouts] },
      variables: { filter: "" }
    });
  }

  handleCompleted = () => {
    this.setState(this.initialState);
  };

  handleInputChange(e, prop) {
    this.setState({ [prop]: e.target.value });
  }

  handleArrayInputChange(e, i, prop) {
    const sets = this.state.sets.map((set, idx) => {
      if (i === idx) {
        return { ...set, [prop]: e.target.value };
      } else {
        return set;
      }
    });

    this.setState({ sets });
  }

  handleAddSet() {
    const newSet = { exercise: {}, reps: 1 };
    this.setState({ sets: [...this.state.sets, newSet] });
  }

  renderExericseOption(exercise) {
    return (
      <option key={`exercise-${exercise.id}`} value={JSON.stringify(exercise)}>
        {exercise.name}
      </option>
    );
  }

  renderExericseLine(set, i) {
    return (
      <div key={`set-${i}`}>
        <label>Exercise:</label>
        <select
          value={set.exercise}
          onChange={e => this.handleArrayInputChange(e, i, "exercise")}
        >
          <option />
          {Exercises.map(this.renderExericseOption)}
        </select>
        <label>Reps:</label>
        <input
          type="number"
          min="1"
          value={set.reps}
          onChange={e => this.handleArrayInputChange(e, i, "reps")}
        />
      </div>
    );
  }

  render() {
    return (
      <Mutation
        mutation={AddWorkoutQuery}
        update={this.handleUpdate}
        onCompleted={this.handleCompleted}
      >
        {(Workout, { data }) => (
          <form onSubmit={e => this.handleSubmit(e, Workout)}>
            <div>
              <label>Workout:</label>
              <input
                value={this.state.name}
                onChange={e => this.handleInputChange(e, "name")}
              />
            </div>
            {this.state.sets.map(this.renderExericseLine)}
            <div>
              <button type="button" onClick={() => this.handleAddSet()}>
                + Add next set
              </button>
              <button type="submit">Add workout</button>
            </div>
          </form>
        )}
      </Mutation>
    );
  }
}

export default WorkoutFormView;

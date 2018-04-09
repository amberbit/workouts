import React from 'react';
import { graphql } from 'react-apollo';

import { WorkoutsQuery } from './queries';

const SetView = (set) => {
  return <div key={ "set_" + set.id } >{set.reps} x {set.exercise.name}</div>
};

const WorkoutView = (workout) => {
  return <div key={workout.id}>
          <p>{workout.name}</p>
            <div>
              <div> {workout.sets.map ( set => SetView(set) ) } </div>
              </div>
          </div>
};

const WorkoutsView = ({ data: {loading, error, workouts, refetch}}) => {
  if (loading) {
    return <p>Loading ...</p>;
  }

  if (error) {
    return <p>{error.message}</p>;
  }

  if (workouts){
    return <div>
             { workouts.map( workout => WorkoutView(workout) ) }
           </div>;
  }

  return "No data loaded"
};

const WorkoutsOptions = { options: (props) => ({ variables: { filter: props.filter } }) }

export default graphql(WorkoutsQuery, WorkoutsOptions)(WorkoutsView);

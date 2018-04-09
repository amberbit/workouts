// import gql query
import gql from 'graphql-tag';

const WorkoutSchema = `{
  id
  name
  sets{
    id
    reps
    exercise{
      id
      name
    }
  }
}`;

const WorkoutsQuery = gql`
  query Workouts($filter: String){
    workouts(byName: $filter)${WorkoutSchema}
  }
`;

const AddWorkoutQuery = gql`
  mutation Workout($name: String!){
    create_workout(name: $name)${WorkoutSchema}
  }
`;

export {
  WorkoutsQuery,
  AddWorkoutQuery,
}
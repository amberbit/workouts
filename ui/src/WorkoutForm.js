import React, { Component } from 'react';

// import gql query
import gql from 'graphql-tag';
import { Mutation } from 'react-apollo';


const AddWorkoutQuery = gql`
  mutation addWorkout($name: String!){
    addWorkout(name: $name){
      id
      name
    }
  }
 `;


class WorkoutFormView extends Component {
  handleSubmit(e, addWorkout) {
    const { input } = this;

    e.preventDefault();
    addWorkout({ variables: { name: input.value }});
    input.value = '';
  }

  render() {
    return (
      <Mutation mutation={AddWorkoutQuery}>
        {(addWorkout, { data }) => (
          <form onSubmit={(e) => this.handleSubmit(e, addWorkout)}>
            <div>
              <input ref={ node => {this.input = node;} } />
            </div>
            <div>
              <button type="submit">Add workout</button>
            </div>
          </form>
        )}
      </Mutation>
    );
  }
}

export default WorkoutFormView;

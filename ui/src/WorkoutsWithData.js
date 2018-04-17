import React, { Component } from 'react';

import WorkoutsView from './Workouts.js'

class WorkoutsViewWithData extends Component {
  constructor(){
    super()

    this.state = { filter: "" }
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange(event) {
    this.setState({filter: event.target.value});
  }

  render() {
    return (
      <div>
        <input type="text" onChange={this.handleChange}  />
        <WorkoutsView filter={this.state.filter} />
      </div>
    );

  }
}

export default WorkoutsViewWithData;

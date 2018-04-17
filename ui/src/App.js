import React, { Component } from 'react';
import { BrowserRouter as Router, Route, Link } from 'react-router-dom'

// import Apollo Client
import { ApolloClient} from 'apollo-client';
import { HttpLink } from 'apollo-link-http';
import { InMemoryCache } from 'apollo-cache-inmemory';

// import Apollo Provider
import { ApolloProvider } from 'react-apollo';

import logo from './logo.svg';
import './App.css';
import WorkoutsViewWithData from './WorkoutsWithData.js'
import WorkoutForm from './WorkoutForm.js'

const client = new ApolloClient({
  link: new HttpLink({ uri: 'http://localhost:4000/api/graphiql' }),
  cache: new InMemoryCache()
});

class App extends Component {
  render() {
    return (
      <div className="App">
        <Router>
          <div>
            <header className="App-header">
              <img src={logo} className="App-logo" alt="logo" />
              <h1 className="App-title">Welcome to React</h1>
                <Link to="/">Workouts</Link>|
                <Link to="/new">Add Workout</Link>
            </header>

            <div className="App-intro">
              <ApolloProvider client={client} >
                <div>
                  <Route exact path="/" component={WorkoutsViewWithData} />
                  <Route exact path="/new" component={WorkoutForm} />
                </div>
              </ApolloProvider>
            </div>

          </div>
        </Router>
      </div>
    );
  }
}

export default App;

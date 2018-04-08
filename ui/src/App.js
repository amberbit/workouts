import React, { Component } from 'react';
import logo from './logo.svg';
import './App.css';
import WorkoutsViewWithData from './WorkoutsWithData.js'

// import Apollo Client
import { ApolloClient} from 'apollo-client';
import { HttpLink } from 'apollo-link-http';
import { InMemoryCache } from 'apollo-cache-inmemory';

// import Apollo Provider
import { ApolloProvider } from 'react-apollo';

const client = new ApolloClient({
  link: new HttpLink({ uri: 'http://localhost:4000/api/graphiql' }),
  cache: new InMemoryCache()
});

class App extends Component {
  render() {
    return (
      <div className="App">
        <header className="App-header">
          <img src={logo} className="App-logo" alt="logo" />
          <h1 className="App-title">Welcome to React</h1>
        </header>
        <div className="App-intro">
          <ApolloProvider client={client} >
            <WorkoutsViewWithData />
          </ApolloProvider>
        </div>
      </div>
    );
  }
}

export default App;

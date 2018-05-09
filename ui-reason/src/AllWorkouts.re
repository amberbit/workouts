module GetAllWorkouts = [%graphql
  {|
    query Workouts{
      workouts{
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
      }
    }
  |}
];

module GetAllWorkoutsQuery = ReasonApollo.CreateQuery(GetAllWorkouts);

let component = ReasonReact.statelessComponent("Query");

let make = _children => {
  ...component,
  render: _self => {
    <GetAllWorkoutsQuery>
      ...(
        ({result}) =>
          <div>
          </div>
      )
    </GetAllWorkoutsQuery>;
  }
};
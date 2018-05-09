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

let renderWorkouts = workouts_array => {
  workouts_array
  |> Array.map(workout => switch(workout) {
  | Some(workout) => switch(workout##name) {
    | Some(name) => <h4> (ReasonReact.string(name)) </h4>
    | None => ReasonReact.string("an unnamed workout")
    }
  | None => ReasonReact.string("a null workout")
  })
};

let make = _children => {
  ...component,
  render: _self =>
    <GetAllWorkoutsQuery>
      ...(
           ({result}) =>
             <div>
               (
                 switch (result) {
                 | Loading => ReasonReact.string("loading")
                 | Data(data) =>
                   switch (data) {
                   | data =>
                     switch (data##workouts) {
                     | None => ReasonReact.string("There are no workouts in the database")
                     | Some(workouts) => renderWorkouts(workouts) |> ReasonReact.array
                     }
                   }
                 | _ => ReasonReact.string("err!")
                 }
               )
             </div>
         )
    </GetAllWorkoutsQuery>,
};
let component = ReasonReact.statelessComponent("Page");

let make = _children => {
  ...component,
  render: _self =>
    <div>
      <h1> (ReasonReact.string("Workouts")) </h1>
       <AllWorkouts />
    </div>
}
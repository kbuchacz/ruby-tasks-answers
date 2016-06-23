# Ruby errors, gotchas and Classes

### Exercise 1-4

Exercises containst code with some common ruby gotchas.
They should be fixed without rewriting whole code and making just minor changes.

### Exercise 5

Implement if_true and if_false methods in TrueClass and FalseClass
in order to check for condition without using if else  keywords
see lib/condition_validator.rb to see how it should work

### Exercise 6

Implement a Car class with following methods

- start - starts engine and sets its speed to a number given in options as start_speed symbol or to 0
- accelerate/1 - which should accept a number of km to accelerate - this method should update car's speed(might accept negative values to decrease speed)
- stop - which should stop the car
- start, accelerate, and stop should take care of controlling car's engine(lib/engine.rb)
- current_speed - should return cars speed as a string in format: "Current speed is X km/h"

implement this class in a way to prevent engine from reporting Engine errors(see lib/engine).
Analyze that class to see what it does.
Make it possible to chain start, accelerate, and stop methods: `@car.start.accelerate(10).stop`


## Setup

### To install dependencies

    bundle install

### Run tests

To run tests execute

    bundle exec rspec spec

Good luck!

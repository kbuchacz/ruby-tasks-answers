require_relative "spec_helper"
require_relative "../exercises/ruby_exercise6"
require_relative "../lib/engine"

describe "RubyExercise6" do
  context "Car" do
    let(:engine_top_speed) { 230 + rand(20) }
    let(:engine) { Engine.new(engine_top_speed) }
    let(:car)  { Car.new(engine) }

    it "responds to engine" do
      expect(car).to respond_to(:engine)
      expect(car.engine).to eql(engine)
    end

    context "#start" do
      let(:random_start_speed) { rand(30) }

      it "starts the engine" do
        car.start
        expect(engine.state).to eql(:started)
      end

      it "starts engine and sets speed to a given speed value" do
        car.start(start_speed: random_start_speed)
        expect(engine.state).to eql(:started)
        expect(engine.speed).to eql(random_start_speed)
      end

      context "when start_speed exceeds engine top speed" do
        let(:random_start_speed) { engine_top_speed + rand(100) + 1 }

        it "sets car and engine speed to engine top_speed" do
          expect{ car.start(start_speed: random_start_speed) }.to_not raise_error
          expect(engine.speed).to eql(engine_top_speed)
          expect(car.speed).to eql(engine_top_speed)
        end
      end
    end

    context "#accelerate" do
      let(:random_acceleration) { rand(30) }

      it "accelerates" do
        car.accelerate(random_acceleration)
        expect(engine.speed).to eql(random_acceleration)
      end

      context "when acceleration would exceed engine top speed" do
        let(:random_acceleration) { engine_top_speed + rand(100) + 1 }

        it "should accelerate car and engine to top speed" do
          expect{ car.accelerate(random_acceleration) }.to_not raise_error
          expect(engine.speed).to eql(engine_top_speed)
          expect(car.speed).to eql(engine_top_speed)
        end
      end

      context "when acceleration would exceed initial speed" do
        let(:random_start_speed) { rand(30) }
        let(:random_acceleration) {  -1 * (random_start_speed + 1) }

        before do
          car.start(start_speed: random_start_speed)
        end

        it "should set car and engine speed to 0" do
          expect{ car.accelerate(random_acceleration) }.to_not raise_error
          expect(car.speed).to eql(0)
          expect(engine.speed).to eql(0)
        end
      end
    end

    context "#stop" do
      let(:random_start_speed) { rand(30) }

      context "when car's speed is greater than 0" do

        before do
          car.start(start_speed: random_start_speed)
        end

        it "stops the speeding car" do
          expect { car.stop }.to_not raise_error
          expect(engine.state).to eql(:stopped)
        end
      end


      context "when car's speed is set to 0" do

        before do
          car.start
        end

        it "stops the car" do
          expect { car.stop }.to_not raise_error
          expect(engine.state).to eql(:stopped)
        end
      end
    end

    context "#current_speed" do
      context "when car is stoped" do
        it "returns valid speed info" do
          expect(car.current_speed).to eql("Current speed is 0 km/h")
        end
      end

      context "when car is speeding" do
        let(:random_start_speed) { rand(30) }

        before do
          car.start(start_speed: random_start_speed)
        end

        it "returns valid speed info" do
          expect(car.current_speed).to eql("Current speed is #{random_start_speed} km/h")
        end
      end
    end

    context "chainable methods" do
      it "methods can be chained together" do
        expect { car.start.accelerate(10).accelerate(20).accelerate(-30).stop }.not_to raise_exception
        expect { car.start.stop.start }.not_to raise_exception
      end
    end

  end
end

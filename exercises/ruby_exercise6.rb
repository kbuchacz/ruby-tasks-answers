class Car
  attr_reader :engine, :speed
  attr_writer :speed

  def initialize(engine)
    @engine = engine
    @speed = 0
  end

  def start(options = {})
    start_speed = options.fetch(:start_speed) { 0 }
    engine.start
    update_speed(start_speed) if start_speed > 0
    self
  end

  def accelerate(value)
    update_speed(value)
    self
  end

  def stop
    update_speed(-speed)
    engine.stop
    self
  end

  def current_speed
    "Current speed is #{speed} km/h"
  end


  private


  def update_speed(value)
    if value + speed  > engine.top_speed
      value = engine.top_speed - speed
    elsif value + speed <= 0
      value  = -speed
    end

    engine.accelerate(value)
    self.speed += value
  end
end

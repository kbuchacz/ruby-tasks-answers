class Engine

  EngineError = Class.new(StandardError)

  attr_reader :top_speed, :speed, :state

  def initialize(top_speed)
    @state = initial_state
    @speed = initial_speed
    @top_speed = top_speed
  end

  def start
    change_state(:started)
  end

  def accelerate(value)
    if can_accelerate?
      @speed += value
      raise_engine_error("Speed boundry exceeded") if speed_boundry_excceded?
    else
      raise_engine_error("Cannot accelerate when engine is stopped")
    end
  end

  def stop
    if can_stop?
      change_state(:stopped)
    else
      raise_engine_error("Cannot stop speeding engine")
    end
  end


  private


  def raise_engine_error(message)
    raise EngineError, message
  end

  def can_stop?
    speed <= initial_speed && state == :started
  end

  def can_accelerate?
    state == :started
  end

  def speed_boundry_excceded?
    speed > top_speed || speed < initial_speed
  end

  def change_state(new_state)
    @state = new_state
  end

  def initial_state
    :started
  end

  def initial_speed
    0
  end

end

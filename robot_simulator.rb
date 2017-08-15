require 'rubygems'

class Robot

  attr_accessor :bearing, :coordinates
  # @var_direction = [':north', ':east', ':south', ':west']

  def initialize
    @bearing = :north
    @coordinates = [0,0]
    @var_direction = [:north, :east, :south, :west]
  end

  def orient(direction)
    if @var_direction.include?(direction)
      @bearing = direction
    else
      raise ArgumentError
    end
  end

  def turn_right
    @bearing
    i = 0
    j = 0
    @var_direction.each {|d|
      j = i if (d == @bearing)
      i += 1
    }
    dir_rotated = @var_direction.rotate
    @bearing = dir_rotated[j]
  end

  def turn_left
    @bearing
    i = 0
    j = 0
    @var_direction.each {|d|
      j = i if (d == @bearing)
      i += 1
    }
    dir_rotated = @var_direction.rotate(-1)
    @bearing = dir_rotated[j]
  end


  def at(x,y)
    @coordinates = [x,y]
  end

  def advance
    case @bearing
    when :north
      @coordinates[1] += 1
    when :east
      @coordinates[0] += 1
    when :south
      @coordinates[1] -= 1
    when :west
      @coordinates[0] -= 1
    end
  end

end



class Simulator

  def initialize
  end

  def instructions(inst)
    inst_array = inst.split("")
    result = []
    inst_array.each {|i|
      case i
        when 'L'
          result.push(:turn_left)
        when 'R'
          result.push(:turn_right)
        when 'A'
          result.push(:advance)
      end
    }
    return result
  end

  def place(robot, **params)
    robot.orient(params[:direction])
    robot.at(params[:x],params[:y])
  end

  def evaluate(robot, command)
    result = self.instructions(command)
    result.each {|r|
      case r
      when :turn_left
        robot.turn_left
      when :turn_right
        robot.turn_right
      when :advance
        robot.advance
      end
    }
  end
end

# robot1 = Robot.new
# robot1[:turn_left]
# # robot1.coordinates[0] +=1 
# # robot1.turn_right
# # robot1.turn_right
# # robot1.turn_right
# robot1.turn_left
# robot1.turn_left
# # robot1.turn_left
# robot1.advance
# puts robot1.coordinates
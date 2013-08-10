class Geometry

  # generate coordinate[y, x]
  def Geometry.[](y, x)
    new(y, x)
  end

  def initialize(y, x)
    @y = y
    @x = x
  end

  attr_accessor :y
  attr_accessor :x

  def +(other)
    case other
    when Geometry
      Geometry[@y + other.y, @x + other.x]
    when Array
      Geometry[@y + other[0], @x + other[1]]
    else
      raise TypeError, "wrong argument type #{other.type} (expected Geometry or Array)"
    end
  end

  def -(other)
    case other
    when Geometry
      Geometry[@y - other.y, @x - other.x]
    when Array
      Geometry[@y - other[0], @x - other[1]]
    else
      raise TypeError, "wrong argument type #{other.type} (expected Geometry or Array)"
    end
  end

  def ==(other)
    type == other.type and @x == other.x and @y == other.y
  end

  def hash
    @x.hash ^ @y.hash
  end

  alias eql? ==

  def to_s
    format("%d@%d", @y, @x)
  end

  def inspect
    format("#<%d@%d>", @y, @x)
  end
end

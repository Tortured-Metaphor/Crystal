require "raylib-cr"

enum ShapeType
  Circle
  Square
  Triangle
end

class Shape
  property x : Float32
  property y : Float32
  property shape_type : ShapeType
  property color : Raylib::Color
  property size : Float32
  property attached : Bool
  property orbit_angle : Float32
  property orbit_distance : Float32
  
  def initialize(@x : Float32, @y : Float32, @shape_type : ShapeType, @color : Raylib::Color)
    @size = 20.0_f32
    @attached = false
    @orbit_angle = 0.0_f32
    @orbit_distance = 0.0_f32
  end

  def attach_to_player(player : Player, attachment_index : Int32)
    @attached = true
    @orbit_distance = 40.0_f32 + (attachment_index * 15.0_f32)
    @orbit_angle = (attachment_index * 60.0_f32) * Math::PI / 180.0_f32
  end

  def follow_player(player : Player)
    if @attached
      @orbit_angle += 0.02_f32
      @x = player.x + Math.cos(@orbit_angle).to_f32 * @orbit_distance
      @y = player.y + Math.sin(@orbit_angle).to_f32 * @orbit_distance
    end
  end

  def draw
    case @shape_type
    when ShapeType::Circle
      Raylib.draw_circle(@x.to_i, @y.to_i, @size, @color)
      if @attached
        Raylib.draw_circle_lines(@x.to_i, @y.to_i, (@size + 2).to_i, Raylib::RAYWHITE)
      end
    when ShapeType::Square
      half_size = @size
      Raylib.draw_rectangle((@x - half_size).to_i, (@y - half_size).to_i, (half_size * 2).to_i, (half_size * 2).to_i, @color)
      if @attached
        Raylib.draw_rectangle_lines((@x - half_size - 2).to_i, (@y - half_size - 2).to_i, (half_size * 2 + 4).to_i, (half_size * 2 + 4).to_i, Raylib::RAYWHITE)
      end
    when ShapeType::Triangle
      v1 = Raylib::Vector2.new(x: @x, y: @y - @size)
      v2 = Raylib::Vector2.new(x: @x - @size * 0.866_f32, y: @y + @size * 0.5_f32)
      v3 = Raylib::Vector2.new(x: @x + @size * 0.866_f32, y: @y + @size * 0.5_f32)
      Raylib.draw_triangle(v1, v2, v3, @color)
      
      if @attached
        v1_outline = Raylib::Vector2.new(x: @x, y: @y - @size - 2)
        v2_outline = Raylib::Vector2.new(x: @x - @size * 0.866_f32 - 2, y: @y + @size * 0.5_f32 + 2)
        v3_outline = Raylib::Vector2.new(x: @x + @size * 0.866_f32 + 2, y: @y + @size * 0.5_f32 + 2)
        Raylib.draw_triangle_lines(v1_outline, v2_outline, v3_outline, Raylib::RAYWHITE)
      end
    end
  end

  def get_bounding_box : {Float32, Float32, Float32, Float32}
    case @shape_type
    when ShapeType::Circle
      {@x - @size, @y - @size, @size * 2, @size * 2}
    when ShapeType::Square
      {@x - @size, @y - @size, @size * 2, @size * 2}
    when ShapeType::Triangle
      {@x - @size, @y - @size, @size * 2, @size * 2}
    else
      {@x - @size, @y - @size, @size * 2, @size * 2}
    end
  end
end
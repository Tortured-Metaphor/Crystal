require "raylib-cr"
require "./shape"

class Player
  property x : Float32
  property y : Float32
  property shape_type : ShapeType
  property color : Raylib::Color
  property size : Float32
  property velocity_x : Float32
  property velocity_y : Float32
  
  SPEED = 200.0_f32
  FRICTION = 0.9_f32

  def initialize(@x : Float32, @y : Float32)
    @shape_type = ShapeType::Circle
    @color = Raylib::GOLD
    @size = 25.0_f32
    @velocity_x = 0.0_f32
    @velocity_y = 0.0_f32
  end

  def update(delta_time : Float32, window_width : Int32, window_height : Int32)
    handle_input(delta_time)
    
    @x += @velocity_x * delta_time
    @y += @velocity_y * delta_time
    
    @velocity_x *= FRICTION
    @velocity_y *= FRICTION
    
    # Keep player on screen
    @x = @x.clamp(@size, window_width - @size)
    @y = @y.clamp(@size, window_height - @size)
  end

  def handle_input(delta_time : Float32)
    if Raylib.key_down?(Raylib::KeyboardKey::Right)
      @velocity_x += SPEED * delta_time
    end
    if Raylib.key_down?(Raylib::KeyboardKey::Left)
      @velocity_x -= SPEED * delta_time
    end
    if Raylib.key_down?(Raylib::KeyboardKey::Down)
      @velocity_y += SPEED * delta_time
    end
    if Raylib.key_down?(Raylib::KeyboardKey::Up)
      @velocity_y -= SPEED * delta_time
    end
    
    if Raylib.key_pressed?(Raylib::KeyboardKey::Space)
      cycle_shape_type
    end
  end

  def cycle_shape_type
    case @shape_type
    when ShapeType::Circle
      @shape_type = ShapeType::Square
    when ShapeType::Square
      @shape_type = ShapeType::Triangle
    when ShapeType::Triangle
      @shape_type = ShapeType::Circle
    end
  end

  def draw
    draw_shape(@x, @y, @size, @color, true)
  end

  def draw_shape(x : Float32, y : Float32, size : Float32, color : Raylib::Color, is_crystal : Bool = false)
    case @shape_type
    when ShapeType::Circle
      if is_crystal
        # Draw crystal effect with multiple circles
        Raylib.draw_circle(x.to_i, y.to_i, size, color)
        Raylib.draw_circle_lines(x.to_i, y.to_i, (size + 3).to_i, Raylib::RAYWHITE)
        Raylib.draw_circle_lines(x.to_i, y.to_i, (size - 5).to_i, Raylib::RAYWHITE)
      else
        Raylib.draw_circle(x.to_i, y.to_i, size, color)
      end
    when ShapeType::Square
      half_size = size
      if is_crystal
        Raylib.draw_rectangle((x - half_size).to_i, (y - half_size).to_i, (half_size * 2).to_i, (half_size * 2).to_i, color)
        Raylib.draw_rectangle_lines((x - half_size - 3).to_i, (y - half_size - 3).to_i, (half_size * 2 + 6).to_i, (half_size * 2 + 6).to_i, Raylib::RAYWHITE)
      else
        Raylib.draw_rectangle((x - half_size).to_i, (y - half_size).to_i, (half_size * 2).to_i, (half_size * 2).to_i, color)
      end
    when ShapeType::Triangle
      v1 = Raylib::Vector2.new(x: x, y: y - size)
      v2 = Raylib::Vector2.new(x: x - size * 0.866_f32, y: y + size * 0.5_f32)
      v3 = Raylib::Vector2.new(x: x + size * 0.866_f32, y: y + size * 0.5_f32)
      
      if is_crystal
        Raylib.draw_triangle(v1, v2, v3, color)
        # Draw outline
        Raylib.draw_triangle_lines(
          Raylib::Vector2.new(x: x, y: y - size - 3),
          Raylib::Vector2.new(x: x - size * 0.866_f32 - 3, y: y + size * 0.5_f32 + 3),
          Raylib::Vector2.new(x: x + size * 0.866_f32 + 3, y: y + size * 0.5_f32 + 3),
          Raylib::RAYWHITE
        )
      else
        Raylib.draw_triangle(v1, v2, v3, color)
      end
    end
  end

  def bounce_off(shape : Shape)
    dx = @x - shape.x
    dy = @y - shape.y
    distance = Math.sqrt(dx * dx + dy * dy)
    
    if distance > 0
      dx /= distance
      dy /= distance
      
      @velocity_x = dx * 150.0_f32
      @velocity_y = dy * 150.0_f32
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
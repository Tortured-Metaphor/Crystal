require "raylib-cr"
require "./player"
require "./shape"
require "./collision_manager"

class Game
  @window_width : Int32
  @window_height : Int32
  @title : String
  @player : Player
  @shapes : Array(Shape)
  @collision_manager : CollisionManager
  @attached_shapes : Array(Shape)

  def initialize(@window_width : Int32, @window_height : Int32, @title : String)
    @player = Player.new((@window_width / 2).to_f32, (@window_height / 2).to_f32)
    @shapes = [] of Shape
    @attached_shapes = [] of Shape
    @collision_manager = CollisionManager.new
    
    init_window
    spawn_initial_shapes
  end

  def init_window
    Raylib.init_window(@window_width, @window_height, @title)
    Raylib.set_target_fps(60)
  end

  def spawn_initial_shapes
    shapes_types = [ShapeType::Circle, ShapeType::Square, ShapeType::Triangle]
    colors = [
      Raylib::RED,
      Raylib::GREEN,
      Raylib::BLUE,
      Raylib::YELLOW,
      Raylib::MAGENTA,
      Raylib::SKYBLUE
    ]

    10.times do
      x = Random.rand(50..(@window_width - 50))
      y = Random.rand(50..(@window_height - 50))
      shape_type = shapes_types.sample
      color = colors.sample
      
      @shapes << Shape.new(x.to_f32, y.to_f32, shape_type, color)
    end
  end

  def run
    until Raylib.close_window?
      update
      draw
    end
    
    Raylib.close_window
  end

  def update
    delta_time = Raylib.get_frame_time
    
    @player.update(delta_time, @window_width, @window_height)
    
    @attached_shapes.each do |shape|
      shape.follow_player(@player)
    end
    
    check_collisions
  end

  def check_collisions
    @shapes.each do |shape|
      next if @attached_shapes.includes?(shape)
      
      if @collision_manager.check_collision(@player, shape)
        if @player.shape_type == shape.shape_type
          @attached_shapes << shape
          shape.attach_to_player(@player, @attached_shapes.size)
        else
          @player.bounce_off(shape)
        end
      end
    end
  end

  def draw
    Raylib.begin_drawing
    Raylib.clear_background(Raylib::DARKBLUE)
    
    @shapes.each do |shape|
      shape.draw unless @attached_shapes.includes?(shape)
    end
    
    @attached_shapes.each do |shape|
      shape.draw
    end
    
    @player.draw
    
    draw_ui
    
    Raylib.end_drawing
  end

  def draw_ui
    Raylib.draw_text("Crystal Shapes", 10, 10, 20, Raylib::RAYWHITE)
    Raylib.draw_text("Match shapes of the same type!", 10, 35, 16, Raylib::RAYWHITE)
    Raylib.draw_text("Attached: #{@attached_shapes.size}", 10, 55, 16, Raylib::RAYWHITE)
    Raylib.draw_text("Current shape: #{@player.shape_type}", 10, 75, 16, Raylib::RAYWHITE)
    
    Raylib.draw_text("Press SPACE to change shape", @window_width - 250, 10, 16, Raylib::RAYWHITE)
    Raylib.draw_text("Arrow keys to move", @window_width - 250, 30, 16, Raylib::RAYWHITE)
  end
end
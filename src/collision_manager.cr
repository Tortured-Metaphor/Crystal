require "./player"
require "./shape"

class CollisionManager
  def check_collision(player : Player, shape : Shape) : Bool
    player_box = player.get_bounding_box
    shape_box = shape.get_bounding_box
    
    check_box_collision(player_box, shape_box)
  end

  def check_box_collision(box1 : {Float32, Float32, Float32, Float32}, box2 : {Float32, Float32, Float32, Float32}) : Bool
    x1, y1, w1, h1 = box1
    x2, y2, w2, h2 = box2
    
    return false if x1 > x2 + w2
    return false if x1 + w1 < x2
    return false if y1 > y2 + h2
    return false if y1 + h1 < y2
    
    true
  end

  def check_circle_collision(x1 : Float32, y1 : Float32, r1 : Float32, x2 : Float32, y2 : Float32, r2 : Float32) : Bool
    dx = x2 - x1
    dy = y2 - y1
    distance = Math.sqrt(dx * dx + dy * dy)
    
    distance < (r1 + r2)
  end
end
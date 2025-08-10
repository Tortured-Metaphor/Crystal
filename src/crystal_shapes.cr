require "raylib-cr"
require "./game"

module CrystalShapes
  VERSION = "0.1.0"

  def self.run
    game = Game.new(800, 600, "Crystal Shapes")
    game.run
  end
end

CrystalShapes.run
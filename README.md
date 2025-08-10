# Crystal Shapes Game

A fun puzzle game where you navigate a crystal around the screen and collect matching shapes!

## Game Features

- **Dynamic Shape Morphing**: Press SPACE to change your crystal between circle, square, and triangle forms
- **Shape Collection**: Collide with shapes that match your current form to collect them
- **Orbital Attachment**: Collected shapes orbit around your crystal in a beautiful pattern
- **Bounce Mechanics**: Non-matching shapes will bounce you away
- **Smooth Movement**: Use arrow keys for fluid crystal navigation

## Prerequisites

1. Install Crystal language (https://crystal-lang.org/install/)
2. Install Raylib library for your system:
   - macOS: `brew install raylib`
   - Ubuntu/Debian: `sudo apt-get install libraylib-dev`
   - Arch Linux: `sudo pacman -S raylib`

## Installation

1. Clone this repository
2. Install dependencies:
   ```bash
   shards install
   ```

## Building and Running

```bash
# Build the game
crystal build src/crystal_shapes.cr -o crystal-shapes

# Run the game
./crystal-shapes
```

Or run directly without building:
```bash
crystal run src/crystal_shapes.cr
```

## How to Play

- **Arrow Keys**: Move your crystal around
- **SPACE**: Change your crystal's shape
- **Goal**: Collect shapes that match your current form
- **Avoid**: Shapes that don't match (they'll bounce you away)

## Game Mechanics

- Your crystal starts as a golden circle
- Shapes spawn randomly around the game area
- Matching shapes attach to your crystal and orbit around it
- Non-matching shapes act as obstacles
- The more shapes you collect, the larger your orbital system becomes!

## Key Features

1. **Player Control**: Use arrow keys to navigate your crystal smoothly across the screen
2. **Shape Morphing**: Press SPACE to transform between circle, square, and triangle forms
3. **Collection System**: Matching shapes automatically attach when you collide with them
4. **Orbital Mechanics**: Collected shapes orbit around your crystal in mesmerizing patterns
5. **Bounce Physics**: Non-matching shapes create a bounce effect, adding challenge to navigation
6. **Visual Effects**: Golden crystal with special glow effects and colored shapes with attachment indicators

## Game Design

The game creates a physics-based puzzle experience where:
- You must strategically change your shape to match targets
- Collected shapes create an increasingly complex orbital system
- The challenge grows as your orbital system expands
- Quick reflexes and planning are rewarded

## Project Structure

```
Crystal/
├── shard.yml              # Project dependencies
├── src/
│   ├── crystal_shapes.cr  # Main entry point
│   ├── game.cr           # Game loop and management
│   ├── player.cr         # Crystal/player controller
│   ├── shape.cr          # Shape entities
│   └── collision_manager.cr # Collision detection
└── README.md
```

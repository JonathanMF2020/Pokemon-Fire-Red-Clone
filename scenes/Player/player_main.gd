extends CharacterBase
class_name PlayerMain

# Set Raycast for collision and State Machine
@export var ray : RayCast2D
@onready var fsm = $FSM as StateMachine

# Store direction player is moving and current move status
var dir : Vector2
var is_moving = false

# Snap player to position on grid on load
func _ready():
	position = position.snapped(Vector2.ONE * TILE_SIZE)
	position += Vector2.ONE * TILE_SIZE

# Check for directional input
func _process(delta):
	dir = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")

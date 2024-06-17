extends CharacterBase
class_name PlayerMain

# Set Raycast for collision, State Machine and Animations
@export var ray : RayCast2D
@onready var fsm = $FSM as StateMachine
@onready var anim = $AnimationTree

# Store current step and current move status
var is_moving = false
var still_moving : bool
var curr_step := "left"

# Snap player to position on grid on load
func _ready():
	position = position.snapped(Vector2.ONE * TILE_SIZE)
	position += Vector2.ONE * TILE_SIZE

# Check for directional input
func _process(delta):
	if Input.is_action_pressed("MoveUp"):
		dir = Vector2.UP
	elif Input.is_action_pressed("MoveDown"):
		dir = Vector2.DOWN
	elif Input.is_action_pressed("MoveLeft"):
		dir = Vector2.LEFT
	elif Input.is_action_pressed("MoveRight"):
		dir = Vector2.RIGHT
	else:
		dir = Vector2.ZERO
	
	if Input.is_action_pressed("sprint"):
		MOVE_SPEED = RUN_SPEED
	
	if (dir):
		walk_anim()
	else:
		if (!still_moving):
			anim.get("parameters/playback").travel("Idle")

func walk_anim():
	anim.get("parameters/playback").travel("Walk")
	
	if (!still_moving):
		anim.set("parameters/Idle/blend_position", dir)
		anim.set("parameters/Walk/blend_position", dir)

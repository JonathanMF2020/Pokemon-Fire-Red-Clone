extends SpriteBase
class_name PlayerMain

const TILE_SIZE = 16
const WALK_SPEED := int(60)
const SPRINT_SPEED := int(120)

@export var movespeed := WALK_SPEED

var input_dir : Vector2
var direction_facing := Vector2.ZERO
var target_position := Vector2()
var is_moving : bool
var can_move : bool

func _ready():
	target_position = position  # Initialize target_position
	is_moving = false
	can_move = true

func _process(_delta):
	handle_input()
	if is_moving:
		Move(_delta)

func handle_input():
	if not is_moving:
		input_dir = Vector2.ZERO
		if input_dir.y == 0:
			input_dir.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
		if input_dir.x == 0:
			input_dir.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up"))
		
		if input_dir != Vector2.ZERO:
			direction_facing = input_dir
			target_position = position + input_dir * TILE_SIZE

			var motion = input_dir * TILE_SIZE
			if not test_move(global_transform, motion):
				is_moving = true

func Move(_delta : float):
	if is_moving:
		var direction = (target_position - position).normalized()
		position += direction * movespeed * _delta
		
		if position.distance_to(target_position) < 1:
			position = target_position
			is_moving = false

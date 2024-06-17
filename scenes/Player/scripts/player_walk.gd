extends State
class_name PlayerWalk

var player : PlayerMain

# Store target position vector, whether player is currently moving between tiles.
# Store player speed (WALK, RUN, BIKE)
var target_pos : Vector2
var player_speed : float

# Grab initial target position on load
func Enter():
	print("Player Moving")
	player = get_tree().get_first_node_in_group("Player")
	target_pos = player.position + (player.dir * player.TILE_SIZE)

# Handle movement and idle logic
func Update(delta: float):
	# If no direction is being inputted, set to idle.
	# Otherwise, start moving in direction as long as target position is not reached
	print(player.dir)
	if (!player.dir):
		state_transition.emit(self, "PlayerIdle")
	elif (player.dir):
		if (player.position == target_pos):
			# Update target position once it is reached
			target_pos = player.position + (player.dir * player.TILE_SIZE)
		else:
			Walk(delta)

# Handle walk functionality
func Walk(delta: float):
	# Set movement and player speed
	var move_dir = Vector2.ZERO
	player_speed = (1 / float(player.MOVE_SPEED))
	
	# Ensure only one direction can be moved at a time. Restrict diagonal movement.
	if (player.dir.y == 0):
		move_dir.x = round(player.dir.x)
	elif (player.dir.x == 0):
		move_dir.y = round(player.dir.y)
	else:
		move_dir.y = round(player.dir.y)
	
	# Set Raycast direction in movement direction for collision detection
	player.ray.target_position = move_dir * player.TILE_SIZE
	player.ray.force_raycast_update()
	
	# Start movement in direction if there is no collision
	if (move_dir and !player.ray.is_colliding()):
		if player.still_moving == false:
			player.still_moving = true
			if player.curr_step == "left":
				player.curr_step = "right"
			elif player.curr_step == "right":
				player.curr_step = "left"
			var tween = create_tween()
			tween.tween_property(player, "position", 
				player.position + move_dir * player.TILE_SIZE, player_speed)
			tween.tween_callback(func(): player.still_moving = false)
	player.move_and_slide()

# Set moving status to false once player goes to idle state
func Exit():
	player.is_moving = false

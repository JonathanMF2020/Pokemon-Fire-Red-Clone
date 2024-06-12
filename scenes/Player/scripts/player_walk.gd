extends State
class_name PlayerWalking

var player : CharacterBody2D

func Enter():
	player = get_tree().get_first_node_in_group("Player")
	print(player.TILE_SIZE)
	
func Update(_delta : float):
	player.position = player.position.snapped(Vector2.ONE * player.TILE_SIZE)
	player.position += Vector2.ONE * player.TILE_SIZE/2

func UnhandledInput(event : InputEvent):
	for dir in player.inputs.keys():
		if event.is_action_pressed(dir):
			Move(dir)

func Move(dir : Vector2):
	player.position += player.inputs[dir] * player.TILE_SIZE

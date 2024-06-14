extends State
class_name PlayerIdle

var player : PlayerMain

func Enter():
	print("Player Idle")
	player = get_tree().get_first_node_in_group("Player")

# Start player walk state once player direction input is found
func Update(_delta : float):
	if (player.dir):
		state_transition.emit(self, "PlayerWalk")

# Set moving status to true once idle exits
func Exit():
	player.is_moving = true

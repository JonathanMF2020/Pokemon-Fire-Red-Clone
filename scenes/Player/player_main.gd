extends CharacterBase
class_name PlayerMain

@onready var fsm = $FSM as StateMachine
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

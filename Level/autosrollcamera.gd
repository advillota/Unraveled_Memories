extends CharacterBody2D

@export var move_speed : float = 50
@export var scene = "none"

func _physics_process(_delta):
	var input_direction = Vector2(
		1,
		3*(Input.get_action_strength("down") - Input.get_action_strength("up"))
	)
	#Update velocity
	velocity = input_direction.normalized() * (move_speed)
	
	#Move and slide function uses velocity of character body to move character on map
	move_and_slide()



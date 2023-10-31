extends CharacterBody2D

@export var move_speed : float = 50
@export var scene = "none"

func _physics_process(_delta):
	#Update velocity
	velocity = Vector2(1, 0) * move_speed
	
	#Move and slide function uses velocity of character body to move character on map
	move_and_slide()
	

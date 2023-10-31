extends CharacterBody2D

@export var move_speed : float = 150
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@onready var all_interactions = []

func _ready():
	update_animation_parameters(starting_direction)
	state_machine.travel("Movement")

func _physics_process(_delta):
	#Get input direction
	var input_direction = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	
	update_animation_parameters(input_direction)
	
	#Update velocity
	velocity = input_direction * move_speed
	
	#Move and slide function uses velocity of character body to move character on map
	move_and_slide()
	
func update_animation_parameters(move_input : Vector2):
	#Don't change animation parameters if there is no move input
	animation_tree.set("parameters/Movement/blend_position", move_input)
		
		

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		cur_interaction.action()
		return

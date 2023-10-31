extends CharacterBody2D

@export var move_speed : float = 100
@export var starting_direction : Vector2 = Vector2(0, 1)

@onready var animation_tree = $AnimationTree
@onready var state_machine = animation_tree.get("parameters/playback")

@onready var all_interactions = []
@onready var interactLabel = $"Interaction Components/Interact Label"

#Get input direction
var input_direction = Vector2(
	Input.get_action_strength("right") - Input.get_action_strength("left"),
	Input.get_action_strength("down") - Input.get_action_strength("up")
	)

func _ready():
	update_animation_parameters(starting_direction)
	update_interactions()

func _physics_process(_delta):
	
	update_animation_parameters(input_direction)
	
	#Update velocity
	velocity = input_direction * move_speed
	
	#Move and slide function uses velocity of character body to move character on map
	move_and_slide()
	
	pick_new_state()
	

func update_animation_parameters(move_input : Vector2):
	#Don't change animation parameters if there is no move input
	if(move_input != Vector2.ZERO):
		animation_tree.set("parameters/Walk/blend_position", move_input)
		animation_tree.set("parameters/idle/blend_position", move_input)

# Choose state based on what is happening with the player
func pick_new_state():
	if(velocity != Vector2.ZERO):
		state_machine.travel("Walk")
	else:
		state_machine.travel("idle")
		

# Interaction Methods

func _on_interaction_area_area_entered(area):
	all_interactions.insert(0, area)
	update_interactions()

func _on_interaction_area_area_exited(area):
	all_interactions.erase(area)
	update_interactions()

func update_interactions():
	if all_interactions:
		interactLabel.text = all_interactions[0].interact_label
	else:
		interactLabel.text = ""

func execute_interaction():
	if all_interactions:
		var cur_interaction = all_interactions[0]
		interactLabel.text = ""
		cur_interaction.action()
		return

func _unhandled_input(_event: InputEvent) -> void:
	var x_axis: float = Input.get_axis("left", "right")
	var y_axis: float = Input.get_axis("up", "down")
	if Input.is_action_just_pressed("interact"):
		execute_interaction()
	elif x_axis:
		input_direction = x_axis * Vector2.RIGHT
	elif y_axis:
		input_direction = y_axis * Vector2.DOWN
	else:
		input_direction = Vector2.ZERO

class_name Interactable extends Area2D

const Balloon = preload("res://Dialogue/balloon.tscn")

@export var dialogue_resource = DialogueResource
@export var dialogue_start = "NPC"
@export var interact_type = "none"
@export var interact_label = "Press E"

func action() -> void:
	
	var balloon: Node = Balloon.instantiate()
	get_tree().current_scene.add_child(balloon)
	if !balloon.start(dialogue_resource,dialogue_start):
		balloon.start(dialogue_resource,dialogue_start)
	match State.changeLevel:
		"house":
			get_tree().change_scene_to_file("res://Level/tutorial_new_maze.tscn")

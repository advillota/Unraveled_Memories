class_name DoorInteractable extends Area2D

@export var scene = "none"

func _on_body_entered(body):
	if body.is_in_group("Player"):
		var sceneload = load(scene)
		get_tree().change_scene_to_packed(sceneload)
		if body.is_in_group("Maze"):
			match State.changeLevel:
				"house":
					State.changeLevel = ""
					State.mom = "beat"

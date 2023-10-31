class_name AutoscrollDeath extends Area2D

@export var interact_type = "none"
@export var scene = "none"

func _on_area_entered(area):
	var sceneload = load(scene)
	get_tree().change_scene_to_packed(sceneload)

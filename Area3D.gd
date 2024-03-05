extends Area3D

@onready var Ball = get_tree().get_first_node_in_group("Ball")

func _on_body_entered(body):
	if body.is_in_group("Ball"):
		OS.alert("Goal!")
		

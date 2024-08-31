extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("fuck u!")
	if body.name == "Player":  
		Global.player_position = body.get_global_position()
		print("Player position saved: ", Global.player_position)
		get_tree().change_scene_to_file("res://maps/battle.tscn")

extends Area2D

@onready var health_component = $Health  # Assuming Health.gd is attached to a child node called "Health"


func _on_body_entered(body: Node2D) -> void:
	print("fuck u 2!")
	if body.name == "Player":
		Global.returning_from_battle = true
		print("Player position saved: ", Global.player_position)
		get_tree().change_scene_to_file("res://maps/map.tscn")
		
	

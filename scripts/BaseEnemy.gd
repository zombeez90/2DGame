extends Area2D

# Define a unique identifier or type for different enemies if needed
@export var enemy_type = "default"

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		handle_battle_trigger(body)
		
func handle_battle_trigger(body: Node2D) -> void:
	# Save the player's position and the current enemy position
	Global.player_position = body.get_global_position()
	Global.last_enemy_position = self.global_position  # Reference the enemy's position
	Global.returning_from_battle = true
	print("Player position saved: ", Global.player_position)
	print("Enemy position saved: ", Global.last_enemy_position)
	
	# Transition to the battle scene
	get_tree().change_scene_to_file("res://maps/battle.tscn")

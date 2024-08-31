extends Node2D

func _ready():
	if Global.returning_from_battle:
		# Adjust player position based on the saved position
		var new_position = Global.player_position  # Apply any offsets if needed
		$Player.set_global_position(new_position)
		print("Player returned from battle, adjusted position: ", new_position)
		
		# Remove the last enemy if it exists
		var last_enemy_position = Global.last_enemy_position
		
		var enemy = get_node("mob")  # Ensure to use the correct path or find by position if needed
		if enemy and enemy.global_position == last_enemy_position:
			enemy.queue_free()
			
		Global.returning_from_battle = false
		
		
		

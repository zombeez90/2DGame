extends Node2D

func _ready():
	if Global.returning_from_battle:
		var new_position = Global.player_position + Vector2(0, 0)  # Adjust as needed
		$Player.set_global_position(new_position)
		print("Player returned from battle, adjusted position: ", new_position)
		Global.returning_from_battle = false  # Reset the flag
	
		var mob = get_node("mob")  
		if mob:
			mob.queue_free()  

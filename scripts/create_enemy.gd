extends Node

func _ready():
	# Initialize the variables with type annotations
	var enemy_type: String
	var health: int
	var battle_points: int
	# Call the function to create the thing
	create_thing(enemy_type, health, battle_points)

func create_thing(type: String, health: int, battle_points: int):
	# Example function implementation
	print("Creating enemy of type: ", type)
	print("Health: ", health)
	print("Battle Points: ", battle_points)
	# Add code to actually create the enemy here

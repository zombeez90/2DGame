extends Node2D

@export var player_scene: PackedScene
@export var enemy_scene: PackedScene
@export var cc: PackedScene
var enemy_data: Dictionary

const MARKER_SIZE = Vector2(25, 25)
var player_spawn_points: Array = []
var enemy_spawn_points: Array = []

# Constants for grid configuration
@export var  PLAYER_SPAWN_POINTS : Array = [
	Vector2(125, 50),  # Front row, left side
	Vector2(125, 125),  # Front row, left side
	Vector2(125, 200),  # Front row, left side
	
	Vector2(50, 50),  # Back row, left side
	Vector2(50, 125),  # Back row, left side
	Vector2(50, 200)   # Back row, left side
]

@export var ENEMY_SPAWN_POINTS : Array = [
	Vector2(325, 50),   # Front row, right side
	Vector2(325, 125),   # Front row, right side
	Vector2(325, 200),  # Front row, right side
	
	Vector2(400, 50),   # Back row, right side
	Vector2(400, 125),   # Back row, right side
	Vector2(400, 200)   # Back row, right side
]

func _ready():
	print("Setting up battle...")
	setup_battle()
	print("Battle setup complete")

func setup_battle() -> void:
	print("Creating spawns...")
	create_spawns()
	
	# visualize_spawn_markers() for debugging 
	visualize_spawn_markers()
	
	print("Spawns complete!")
	print("Creating players...")
	spawn_players(3)
	print("Players complete!")
	print("Creating enemies...")
	
	
	spawn_enemies(3)
	print("Enemies complete!")	

func create_spawns() -> void:
	print("Creating player spawns...")
	var player_rows = ["F", "F", "F", "B", "B", "B"]
	
	for i in range(len(PLAYER_SPAWN_POINTS)):
		var pos = PLAYER_SPAWN_POINTS[i]
		var row = player_rows[i]
		print("Processing player position: ", pos, " with label: ", i + 1)
		if pos.x >= 0 and pos.x <= 475 and pos.y >= 0 and pos.y <= 275:
			player_spawn_points.append([pos, row])
			print("Player spawn point added at: ", pos, " with label: ", i + 1, " Row: ", row)
		else:
			print("Player position out of bounds: ", pos)

	print("Creating enemy spawns...")
	var enemy_rows = ["F", "F", "F", "B", "B", "B"]
	for i in range(len(ENEMY_SPAWN_POINTS)):
		var pos = ENEMY_SPAWN_POINTS[i]
		var row = enemy_rows[i]
		print("Processing enemy position: ", pos, " with label: ", i + 1)
		if pos.x >= 0 and pos.x <= 475 and pos.y >= 0 and pos.y <= 275:
			enemy_spawn_points.append([pos, row])
			print("Enemy spawn point added at: ", pos, " with label: ", i + 1, " Row: ", row)
		else:
			print("Enemy position out of bounds: ", pos)

func create_visual_markers(spawn_points: Array, color: Color) -> void:
	for i in range(len(spawn_points)):
		var pos = spawn_points[i][0]
		var row = spawn_points[i][1]
		var marker = ColorRect.new()
		marker.color = color
		marker.size = MARKER_SIZE
		marker.position = pos - MARKER_SIZE / 2
		add_child(marker)

		var label = Label.new()
		label.text = str(i + 1) + " (" + row + ")"
		label.position = pos
		label.z_index = 1
		add_child(label)
		print("Marker created at: ", pos, " with color: ", color)

func visualize_spawn_markers() -> void:
	create_visual_markers(player_spawn_points, Color(0, 0, 1, 0.25))  # Blue markers for players
	create_visual_markers(enemy_spawn_points, Color(1, 0, 0, 0.25))  # Red markers for enemies
	


func spawn_players(count: int) -> void:
	var spawn_points = player_spawn_points.slice(0, count)  # Select only the number needed
	for i in range(count):
		var player = player_scene.instantiate()
		var spawn_point = spawn_points[i]
		player.position = spawn_point[0]
		add_child(player)
		print("Player spawned at position: ", player.position)

func spawn_enemies(count: int) -> void:
	# Create separate lists for front and back row spawn points
	var front_row_points: Array = []
	var back_row_points: Array = []
	
	# Sort enemy spawn points into front and back rows
	for spawn_point in enemy_spawn_points:
		if spawn_point[1] == "F":
			front_row_points.append(spawn_point[0])
		elif spawn_point[1] == "B":
			back_row_points.append(spawn_point[0])

	# Loop through the enemy types
	for i in range(count):
		
		var enemy = enemy_scene.instantiate()
		
		var enemy_data_list = load_enemy_list()
		var pick = pick_random_enemy(enemy_data_list)
		print(pick)
		print(enemy_data_list[pick])
		
		var health = enemy_data_list[pick].health
		var battle_points = enemy_data_list[pick].battle_points
		
		var c = cc.instantiate()
		c.create_thing(pick,health,battle_points)
		print(c)
		
		
		
		
		# Choose a spawn point based on enemy type
		if enemy.enemy_type == "ranged" and back_row_points.size() > 0:
			enemy.position = back_row_points.pop_front()  # Prefer back row for ranged
		elif enemy.enemy_type == "melee" and front_row_points.size() > 0:
			enemy.position = front_row_points.pop_front()  # Prefer front row for melee
		else:
			# If there are no preferred spots left, fallback to any remaining spawn points
			if front_row_points.size() > 0:
				enemy.position = front_row_points.pop_front()
			elif back_row_points.size() > 0:
				enemy.position = back_row_points.pop_front()
		
		# Add the enemy to the scene
		add_child(enemy)
		print(enemy.enemy_type.capitalize(), " enemy spawned at position: ", enemy.position)

func load_enemy_list():
	var enemy_data_script = load("res://scripts/enemy_data.gd").new() as Node
	var enemy_data_list = enemy_data_script.ENEMY_DATA
	return enemy_data_list
	
func pick_random_enemy(enemy_data_list: Dictionary):
	var random_index = randi() % enemy_data_list.size()
	var random_enemy_type = enemy_data_list.keys()[random_index]
	# print(random_index)
	return random_enemy_type

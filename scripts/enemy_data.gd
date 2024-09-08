# enemy_data.gd
extends Node
class_name EnemyData 

var ENEMY_DATA = {
	"goblin": {
		"health": 100,
		"attack_power": 15,
		"movement_speed": 120,
		"type": "melee",
		"element": "earth",
		"battle_points": 20
	},
	"wolf": {
		"health": 120,
		"attack_power": 20,
		"movement_speed": 150,
		"type": "melee",
		"element": "earth",
		"battle_points": 30
	},
	"ranged_archer": {
		"health": 80,
		"attack_power": 25,
		"movement_speed": 100,
		"type": "ranged",
		"element": "wind",
		"battle_points": 40
	},
	"rare_enemy": {
		"health": 300,
		"attack_power": 50,
		"movement_speed": 200,
		"type": "special",
		"element": "fire",
		"battle_points": 80,
		"is_rare": true
	}
}

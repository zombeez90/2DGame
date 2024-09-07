extends Node

@export var max_health: int = 100
var current_health: int

func _ready():
	current_health = max_health

func take_damage(damage: int) -> void:
	current_health -= damage
	print("Current health: ", current_health)
	if current_health <= 0:
		die()

func heal(amount: int) -> void:
	current_health = min(current_health + amount, max_health)

func die() -> void:
	print("Entity has died.")
	queue_free()

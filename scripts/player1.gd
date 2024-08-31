extends CharacterBody2D

@export var speed: int = 50
@export var shift_mod: int = 25 
@onready var sprite = $AnimatedSprite2D

const INPUT_LEFT = "left"
const INPUT_RIGHT = "right"
const INPUT_UP = "up"
const INPUT_DOWN = "down"
const INPUT_SHIFT = "shift"

func _process(delta):
	move(delta)
	move_and_slide()

# Handles movement logic
func move(delta):
	# Calculate velocity based on input
	velocity = calculate_velocity()

	# Apply the velocity to the character
	position += velocity * delta

	# Update sprite animation based on movement
	update_animation()

# Calculates the velocity based on input
func calculate_velocity() -> Vector2:
	var current_shift_mod = shift_mod if Input.is_action_pressed(INPUT_SHIFT) else 0
	var mod_speed = speed + current_shift_mod
	var velocity = Vector2.ZERO
	
	# Collect movement input into a direction vector
	if Input.is_action_pressed(INPUT_LEFT):
		velocity.x -= 1
	if Input.is_action_pressed(INPUT_RIGHT):
		velocity.x += 1
	if Input.is_action_pressed(INPUT_UP):
		velocity.y -= 1
	if Input.is_action_pressed(INPUT_DOWN):
		velocity.y += 1
	
	# Normalize to avoid faster diagonal movement and scale by speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * mod_speed
	
	return velocity

# Updates the sprite animation based on velocity
func update_animation():
	# Check the current velocity to decide the animation
	if velocity.x < 0:
		sprite.play("walk_left")
	elif velocity.x > 0:
		sprite.play("walk_right")
	elif velocity.y < 0:
		sprite.play("walk_up")
	elif velocity.y > 0:
		sprite.play("walk_down")
	else:
		sprite.play("idle")

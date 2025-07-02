extends CharacterBody2D
# Sets speed and jump velocity
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Default built in gravity in Godot
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimationPlayer") # Sets the animation sprite for code reusablility 

# Idle Animation 
func _ready(): 
	animation.play("Idle")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animation.play("Jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	
	if direction == -1:
		get_node("AnimatedSprite2D").flip_h = false
	elif direction == 1:
		get_node("AnimatedSprite2D").flip_h = true

	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			animation.play("Run") # Plays run animation 

	else:
		animation.play("Idle")
		if velocity.y == 0:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y > 0:
			animation.play("Fall")
	move_and_slide()
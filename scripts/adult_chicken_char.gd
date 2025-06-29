extends CharacterBody2D

# Sets speed and jump velocity
const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Default built in gravity in Godot
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimatedSprite2D") # Sets the animation sprite for code reusablility 

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
	
	if direction:
		velocity.x = direction * SPEED
		animation.play("Run") # Plays run animation 

	else:
		animation.play("Idle")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

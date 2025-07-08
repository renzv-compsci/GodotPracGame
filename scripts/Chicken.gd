extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animation = get_node("AnimationPlayer")

func _ready(): 
    connect("area_entered", _on_area_entered)
    animation.play("Idle")

func _on_area_entered(area):
    print("Chicken collided with: ", area.name, "groups: ", area.get_groups())
    if area.is_in_group("raining_arrows"):
        print("Game Over!")
        var gameworld = get_node_or_null("/root/GameWorld")
        if gameworld:
            gameworld.game_over()

func _physics_process(delta):
    # Add gravity
    if not is_on_floor():
        velocity.y += gravity * delta

    # Handle jump
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = JUMP_VELOCITY
        animation.play("Jump")

    # Handle left/right movement
    var direction = Input.get_axis("ui_left", "ui_right")

    if direction == -1:
        get_node("AnimatedSprite2D").flip_h = false
    elif direction == 1:
        get_node("AnimatedSprite2D").flip_h = true

    if direction != 0:
        velocity.x = direction * SPEED
        if is_on_floor():
            if animation.current_animation != "Run":
                animation.play("Run")
    else:
        if is_on_floor():
            if animation.current_animation != "Idle":
                animation.play("Idle")
            velocity.x = move_toward(velocity.x, 0, SPEED)
        elif velocity.y > 0:
            if animation.current_animation != "Fall":
                animation.play("Fall")

    move_and_slide()
   
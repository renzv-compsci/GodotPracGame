extends Area2D
# Moves arrow downwards a a constant speed 
@export var  speed = 900

func _ready(): 
    connect("body_entered", _on_body_entered)
    add_to_group("raining_arrows")
    z_index = 10

func _on_body_entered(body):
    print("Colleded with: ", body.name)
    if body.name == "Chicken": 
        print("Game Over!")
        get_tree().paused = true # Pause the game 

func _physics_process(delta):
    position.y += speed * delta 
    if position.y > 900: 
        queue_free()

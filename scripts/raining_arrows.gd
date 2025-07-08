extends Area2D
# Moves arrow downwards a a constant speed 
@export var  speed = 900

func _ready(): 
	connect("body_entered", _on_body_entered)
	add_to_group("raining_arrows")
	z_index = 10

func _on_body_entered(body):
	print("Collieded with: ", body.name)
	if body.name == "AdultChickenChar": 
		print("Game Over!") 
		var gameworld = get_node_or_null("/root/GameWorld")
		if gameworld:
			gameworld.game_over()

func _physics_process(delta): 
	position.y += speed * delta 
	if position.y > 900: 
		queue_free()

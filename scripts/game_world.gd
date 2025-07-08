extends Node2D

@export var scene_to_instance: PackedScene
@onready var timer = $Timer

var window_width = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$RestartButton.visible = false 
	window_width = get_viewport().get_visible_rect().size.x
	timer.timeout.connect(_on_timer_timeout)
	timer.start()

	if scene_to_instance:
		var instance = scene_to_instance.instantiate()
		instance.position = Vector2(randf_range(0, window_width), 0)
		add_child(instance)

func _on_timer_timeout():
	print("Timer triggered!")
	for i in range(3): #Spawns 3 arrows each time 
		if scene_to_instance:
			var spawnedarrows = scene_to_instance.instantiate()
			# Randomize spawn position
			spawnedarrows.position = Vector2(randf_range(0, window_width) ,0)
			spawnedarrows.speed = randf_range(700, 1200) #Makes arrow falls fast
			print("Arrow at: ", spawnedarrows.position)
			add_child(spawnedarrows)
			timer.wait_time = randf_range(0.07, 0.25) #Random internval of arrows 
			timer.start()

func game_over():
	get_tree().paused = true
	$RestartButton.visible = true # Makes the button only visible when the game is over 

func _on_restart_button_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/main.tscn")

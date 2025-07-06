extends Node2D

const SPEED = 300.0

func _process(delta):
    position.y += SPEED * delta 
extends Node2D

var vivo = 100

func _ready():
	set_process(true)

func _process(delta):
	if vivo <= 0:
		free()

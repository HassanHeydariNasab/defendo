extends Node2D

var vivo = 100

func _ready():
	set_process(true)

func _process(delta):
	if vivo <= 0:
		free()


func _on_Area2D_input_event( viewport, event, shape_idx ):
	get_tree().get_root().get_node("Radiko").kaptitajxo = null
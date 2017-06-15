extends Node2D

var vivo = 1000
#onready var M = get_node("Malamiko_0")
onready var Vivo = get_node("Vivo")
func _ready():
	set_process(true)

func _process(delta):
	#M.set_rot(M.get_rot()+deg2rad(7))
	Vivo.set_text(str(vivo))
	if vivo <= 0:
		get_tree().get_root().get_node("Radiko").mono += 100
		free()


func _on_Area2D_input_event( viewport, event, shape_idx ):
	#get_tree().get_root().get_node("Radiko").kaptitajxo = null
	pass
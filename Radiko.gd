extends Node2D

var kaptitajxo = null
var vivo = 100
var Pistoloj = []

func _ready():
	pass

func _on_Area2D_body_enter( korpo ):
	Pistoloj.append(korpo)
	if Pistoloj.size() == 2:
		if Pistoloj[0].get_name() == "Kanono" and Pistoloj[1].get_name() == "Kanono":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()
		elif Pistoloj[0].get_name() == "Lasero" and Pistoloj[1].get_name() == "Lasero":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()

func _on_Area2D_body_exit( korpo ):
	Pistoloj.erase(korpo)

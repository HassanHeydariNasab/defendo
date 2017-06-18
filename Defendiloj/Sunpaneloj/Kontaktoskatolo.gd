extends Node2D

var Pistoloj = []

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if Pistoloj.size() == 1:
		Pistoloj[0].get_parent().enreta = true
	else:
		for Pistolo in Pistoloj:
			Pistolo.get_parent().enreta = false

func _on_Kontaktoskatolo_body_enter( korpo ):
	Pistoloj.append(korpo)

func _on_Kontaktoskatolo_body_exit( korpo ):
	Pistoloj.erase(korpo)
	korpo.get_parent().enreta = false
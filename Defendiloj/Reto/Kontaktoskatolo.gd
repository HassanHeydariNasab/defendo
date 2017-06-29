extends Node2D

var Pistoloj = []

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	if is_visible():
		if Pistoloj.size() == 1:
			Pistoloj[0].get_parent().enreta = true
		else:
			for Pistolo in Pistoloj:
				Pistolo.get_parent().enreta = false

func _on_Kontaktoskatolo_area_enter( areo ):
	if areo.get_name() == "Reta":
		Pistoloj.append(areo)


func _on_Kontaktoskatolo_area_exit( areo ):
	if areo.get_name() == "Reta":
		Pistoloj.erase(areo)
		areo.get_parent().enreta = false

extends Node2D

var pistolo
var nivelo = 0
var angulo = 0

onready var Kuglo = get_node("Kuglo")
onready var Vivtempilo = get_node("Vivtempilo")

func _ready():
	if nivelo != 0 and angulo != 0:
		set_fixed_process(true)

func _fixed_process(delta):
	Kuglo.move((Vector2(4.0*(log(nivelo)+1.0)*cos(angulo), -4.0*(log(nivelo)+1.0)*sin(angulo))))

func _on_Area2D_body_enter( korpo ):
	if korpo.get_name() == "Malamiko":
		if korpo.tipo == 0 or korpo.tipo == 1:
			korpo.get_parent().vivo -= log(nivelo+3)*10-7
			queue_free()

func _on_Vivtempilo_timeout():
	queue_free()
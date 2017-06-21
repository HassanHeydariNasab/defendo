extends Node2D

var pistolo
var nivelo = 0
var angulo = 0

onready var Vivtempilo = get_node("Vivtempilo")

func _ready():
	if nivelo != 0 and angulo != 0:
		set_fixed_process(true)

func _fixed_process(delta):
	get_node("Kuglo").move((Vector2(4.0*(log(nivelo)+1.0)*cos(angulo), -4.0*(log(nivelo)+1.0)*sin(angulo))))

func _on_Area2D_body_enter( korpo ):
	var patro_nomo = korpo.get_parent().get_name()
	if "Malamiko_0_" in patro_nomo or "Malamiko_1_" in patro_nomo:
		korpo.get_parent().vivo -= nivelo*2
		queue_free()


func _on_Vivtempilo_timeout():
	queue_free()
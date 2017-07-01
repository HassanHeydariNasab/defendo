extends Node2D

var pistolo
var nivelo = 0
var angulo = 0

onready var Laserradio = get_node("Laserradio")
onready var Vivtempilo = get_node("Vivtempilo")

func _ready():
	if nivelo != 0 and angulo != 0:
		set_global_rot(angulo+deg2rad(90))
		set_fixed_process(true)

func _fixed_process(delta):
	Laserradio.move((Vector2(25.0*cos(angulo), -25.0*sin(angulo))))
	set_scale(Vector2(1, (5-Vivtempilo.get_time_left())*10))

func _on_Area2D_body_enter( korpo ):
	var patro_nomo = korpo.get_parent().nomo
	if patro_nomo == "Malamiko_0_" or patro_nomo == "Malamiko_1_" or patro_nomo == "Malamiko_2_":
		korpo.get_parent().vivo -= log(nivelo+3)*20-10
		queue_free()


func _on_Vivtempilo_timeout():
	queue_free()
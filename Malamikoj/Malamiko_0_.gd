extends Node2D

var vivo = 999
onready var M = get_node("Malamiko_0")
onready var Vivo = get_node("Malamiko_0/Vivo")
onready var Vivo_P = get_node("Malamiko_0/Vivo_P")
var angulo = 0

func _ready():
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	#M.set_rot(M.get_rot()+deg2rad(7))
	Vivo.set_text(str(vivo))
	Vivo_P.set_scale(Vector2(vivo/999.0, 1))
	
	if vivo <= 0:
		get_tree().get_root().get_node("Radiko").mono += 100
		free()

func _fixed_process(delta):
	angulo = get_angle_to(get_tree().get_root().get_node("Radiko/Bazo").get_pos())
	M.set_rot(angulo+deg2rad(180))
	angulo += deg2rad(-90)
	M.move(Vector2(.2*cos(angulo), -.2*sin(angulo)))
	if M.is_colliding():
		if M.get_collider().get_name() == "Bazo":
			get_tree().get_root().get_node("Radiko").vivo -= 10
			free()

func _on_Area2D_input_event( viewport, event, shape_idx ):
	#get_tree().get_root().get_node("Radiko").kaptitajxo = null
	pass
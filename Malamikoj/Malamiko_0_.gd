extends Node2D

signal malamiko_0_mortigxis
signal malamiko_0_batis_bazon

var vivo = 99
var komenca_vivo = 99.0
var rapido = 2
onready var M = get_node("Malamiko_0")
onready var Vivo = get_node("Malamiko_0/Vivo")
onready var Vivo_P = get_node("Malamiko_0/Vivo_P")
onready var Efekto = get_node("Malamiko_0/Efekto")
onready var Radiko = get_tree().get_root().get_node("Radiko")
var angulo = 0

func _ready():
	connect('malamiko_0_mortigxis', Radiko, '_je_malamiko_0_mortigxis')
	connect('malamiko_0_batis_bazon', Radiko, '_je_malamiko_0_batis_bazon')
	Efekto.interpolate_property(M, 'transform/scale',
			M.get_scale(), Vector2(1.3, 1.3), 0.5,
			Tween.TRANS_QUAD, Tween.EASE_OUT
		)
	Efekto.interpolate_property(M, 'visibility/opacity',
			1, 0, 0.5,
			Tween.TRANS_QUAD, Tween.EASE_OUT
		)
	set_process(true)
	set_fixed_process(true)

func _process(delta):
	#M.set_rot(M.get_rot()+deg2rad(7))
	if vivo <= 0:
		M.clear_shapes()
		emit_signal('malamiko_0_mortigxis', get_scale().x)
		Efekto.start()
		set_process(false)
		set_fixed_process(false)

func _fixed_process(delta):
	Vivo.set_text(str(vivo))
	Vivo_P.set_scale(Vector2(vivo/komenca_vivo, 1))
	angulo = get_angle_to(get_tree().get_root().get_node("Radiko/Bazo").get_pos())
	M.set_rot(angulo+deg2rad(180))
	angulo += deg2rad(-90)
	M.move(Vector2(rapido*cos(angulo), -rapido*sin(angulo)))
	if M.is_colliding():
		if M.get_collider().get_name() == "Bazo":
			emit_signal('malamiko_0_batis_bazon', get_scale().x)
			M.clear_shapes()
			Efekto.start()
			set_process(false)
			set_fixed_process(false)

func _on_Area2D_input_event( viewport, event, shape_idx ):
	#get_tree().get_root().get_node("Radiko").kaptitajxo = null
	pass

func _on_Efekto_tween_complete( object, key ):
	queue_free()

extends Node2D

signal malamiko_mortigxis
signal malamiko_batis_bazon

var vivo = 99
var komenca_vivo = 99.0
var rapido = 2
var komenca_rapido = 2
var min_rapido = 2
var angulo = 0

onready var M = get_node("Malamiko")
onready var Vivo_P = get_node("Malamiko/Vivo_P")
onready var Efekto = get_node("Malamiko/Efekto")
onready var Radiko = get_tree().get_root().get_node("Radiko")
onready var M0 = Radiko.M0
onready var Mj = Radiko.Mj
var tipo = null

func _ready():
	tipo = M.tipo
	connect('malamiko_mortigxis', Radiko, '_je_malamiko_mortigxis')
	connect('malamiko_batis_bazon', Radiko, '_je_malamiko_batis_bazon')
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
	Vivo_P.set_scale(Vector2(vivo/komenca_vivo, 1))
	if tipo == 2:
		M.get_node("Sprite").rotate(0.05)
	elif vivo > 0:
		M.get_node("Partiklo").set_explosiveness(vivo/komenca_vivo)
	if vivo <= 0:
		M.clear_shapes()
		Vivo_P.hide()
		if tipo == 1:
			for i in range(4):
				randomize()
				var M_ = M0.instance()
				M_.set_global_pos(M.get_global_pos()+Vector2(rand_range(-150.0, 150.0), rand_range(-75.0, 75.0)))
				M_.set_scale(Vector2(0.3, 0.3))
				M_.vivo = 40
				M_.komenca_vivo = 40.0
				M_.rapido = 3.2
				M_.komenca_rapido = 3.2
				Mj.add_child(M_)
		emit_signal('malamiko_mortigxis', komenca_vivo)
		Efekto.start()
		set_process(false)
		set_fixed_process(false)

func _fixed_process(delta):
	angulo = get_angle_to(get_tree().get_root().get_node("Radiko/Bazo").get_global_pos())
	M.set_rot(angulo+deg2rad(180))
	angulo += deg2rad(-90)
	M.move(Vector2(rapido*cos(angulo), -rapido*sin(angulo)))
	if M.is_colliding():
		if M.get_collider().get_name() == "Bazo":
			emit_signal('malamiko_batis_bazon', komenca_vivo)
			M.clear_shapes()
			Vivo_P.hide()
			Efekto.start()
			set_process(false)
			set_fixed_process(false)

func _on_Efekto_tween_complete( object, key ):
	queue_free()

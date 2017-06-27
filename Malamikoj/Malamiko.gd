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
onready var Vivo = get_node("Malamiko/Vivo")
onready var Vivo_P = get_node("Malamiko/Vivo_P")
onready var Efekto = get_node("Malamiko/Efekto")
onready var Radiko = get_tree().get_root().get_node("Radiko")
onready var M0 = Radiko.M0
onready var Mj = Radiko.Mj
var nomo = ""

func _ready():
	var nomo_ = get_name().split("@")
	if nomo_.size() == 1:
		nomo = nomo_[0]
	else:
		nomo = nomo_[1]
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
	if "Malamiko_2_" in get_name():
		M.get_node("Sprite").rotate(0.05)
	if vivo <= 0:
		M.clear_shapes()
		Vivo_P.hide()
		if "Malamiko_1_" in get_name():
			for i in range(4):
				randomize()
				var M_ = M0.instance()
				M_.set_global_pos(M.get_global_pos()+Vector2(rand_range(-150.0, 150.0), rand_range(-75.0, 75.0)))
				M_.set_scale(Vector2(0.3, 0.3))
				M_.vivo = 20
				M_.komenca_vivo = 20.0
				M_.rapido = 3
				M_.komenca_rapido = 3
				Mj.add_child(M_)
		emit_signal('malamiko_mortigxis', komenca_vivo)
		Efekto.start()
		set_process(false)
		set_fixed_process(false)

func _fixed_process(delta):
	Vivo.set_text(str(vivo))
	Vivo_P.set_scale(Vector2(vivo/komenca_vivo, 1))
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

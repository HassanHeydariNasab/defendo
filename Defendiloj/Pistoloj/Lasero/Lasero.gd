extends Node2D

var Malamikoj = []

onready var F = get_node("Fiksata")
onready var P = get_node("Lasero")
onready var Kuglujo = get_node("Lasero/Kuglujo")
onready var Elektumo = get_node("Lasero/Elektumo")
onready var Nivelo = get_node("Nivelo")
onready var K = preload("res://Defendiloj/Kugloj/Laserradio/Laserradio.tscn")
var atendado_nova_K = 0
var nivelo = 1

func _ready():
	set_process(true)

func _on_Area2D_body_enter( korpo ):
	if korpo.get_name() == "Malamiko_0":
		Malamikoj.push_front(korpo)

func _on_Area2D_body_exit( korpo ):
	if korpo.get_name() == "Malamiko_0":
		Malamikoj.remove(Malamikoj.find(korpo))
	
func _process(delta):
	if Malamikoj.size() > 0:
		#se la malamiko liberigxis
		for Malamiko in Malamikoj:
			if not weakref(Malamiko).get_ref():
				Malamikoj.erase(Malamiko)
		if Malamikoj.size() > 0:
			#PORFARI sxangxu gxin laux la strategio
			var Malamiko = Malamikoj[0]
			var angulo = get_angle_to(Malamiko.get_global_pos())
			angulo -= deg2rad(180)
			P.set_rot(angulo)
			atendado_nova_K += 1
			if atendado_nova_K < 100 and atendado_nova_K % 50 == 0:
				var K_ = K.instance()
				K_.pistolo = self
				K_.nivelo = nivelo
				K_.angulo = angulo
				K_.set_rot(angulo+deg2rad(90))
				K_.set_global_pos(Kuglujo.get_global_pos())
				K_.set_global_scale(Vector2(nivelo, nivelo))
				get_tree().get_root().add_child(K_)
			elif atendado_nova_K >= 100:
				atendado_nova_K = 2
	if get_tree().get_root().get_node("Radiko").kaptitajxo == self:
		set_global_pos(get_global_mouse_pos())
		Elektumo.show()
	else:
		Elektumo.hide()
	
	Nivelo.set_text(str(nivelo))

func _on_Lasero_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			get_tree().get_root().get_node("Radiko").kaptitajxo = self
		else:
			get_tree().get_root().get_node("Radiko").kaptitajxo = null
	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.button_mask == 0:
			get_tree().get_root().get_node("Radiko").kaptitajxo = self
		else:
			get_tree().get_root().get_node("Radiko").kaptitajxo = null
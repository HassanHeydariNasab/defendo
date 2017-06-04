extends Node2D

var Malamikoj = []
var Kugloj_anguloj = {}
onready var F = get_node("Fiksata")
onready var P = get_node("Pistolo_0")
onready var K = preload("res://Defendiloj/Kugloj/Kuglo_0/Kuglo_0_.tscn")
var atendado_nova_K = 0
var kaptita = false

func _ready():
	set_process(true)

func _on_Area2D_body_enter( korpo ):
	Malamikoj.push_front(korpo)

func _on_Area2D_body_exit( korpo ):
	Malamikoj.remove(Malamikoj.find(korpo))
	
func _process(delta):
	if Malamikoj.size() > 0:
		#PORFARI sxangxu gxin laux la strategio
		var Malamiko = Malamikoj[0]
		
		#se la malamiko liberigxis
		if not weakref(Malamiko).get_ref():
			Malamikoj.remove(Malamikoj.find(Malamiko))
		else:
			var angulo = get_angle_to(Malamiko.get_global_pos())
			angulo -= deg2rad(180)
			P.set_rot(angulo)
			atendado_nova_K += 1
			if atendado_nova_K < 1000 and atendado_nova_K % 10 == 0:
				var K_ = K.instance()
				K_.pistolo = self
				Kugloj_anguloj[K_] = angulo
				get_tree().get_root().add_child(K_)
				K_.set_global_pos(P.get_global_pos())
				K_.get_node("Kuglo_0").set_linear_velocity(Vector2(500*cos(angulo), -500*sin(angulo)))
			#else:
				#atendado_nova_K = 0
	if get_tree().get_root().get_node("Radiko").kaptitajxo != null:
		get_tree().get_root().get_node("Radiko").kaptitajxo.set_global_pos(get_global_mouse_pos())


#func _on_Pistolo_0_mouse_enter():
	#if get_tree().get_root().get_node("Radiko").kaptitajxo == null:
		#get_tree().get_root().get_node("Radiko").kaptitajxo = self

func _on_Pistolo_0_input_event( viewport, event, shape_idx ):
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
			
extends Node2D

var Malamikoj = []
var Kugloj_anguloj = {}
onready var F = get_node("Fiksata")
onready var P = get_node("Pistolo_0")
onready var K = preload("res://Defendiloj/Kugloj/Kuglo_0/Kuglo_0_.tscn")
var atendado_nova_K = 0

func _ready():
	set_process(true)

func _on_Area2D_body_enter( korpo ):
	Malamikoj.push_front(korpo)
	print(korpo.get_name())

func _process(delta):
	#F.set_global_pos(get_global_pos())
	if Malamikoj.size() > 0:
		var angulo = get_angle_to(Malamikoj[0].get_global_pos())
		angulo -= deg2rad(180)
		P.set_rot(angulo)
		atendado_nova_K += 1
		if atendado_nova_K < 1000 and atendado_nova_K % 100 == 0:
			var K_ = K.instance()
			Kugloj_anguloj[K_] = angulo
			get_tree().get_root().add_child(K_)
			K_.set_global_pos(P.get_global_pos())
			K_.get_node("Kuglo_0").set_linear_velocity(Vector2(300*cos(angulo), -300*sin(angulo)))
		#else:
			#atendado_nova_K = 0

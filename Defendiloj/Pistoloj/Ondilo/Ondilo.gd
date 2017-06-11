extends Node2D

var Malamikoj = []

onready var F = get_node("Fiksata")
onready var P = get_node("Ondilo")
onready var Elektumo = get_node("Ondilo/Elektumo")
onready var Ondo = get_node("Ondo")
onready var Nivelo = get_node("Nivelo")
#onready var K = preload("res://Defendiloj/Kugloj/Kuglo/Kuglo.tscn")
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
			atendado_nova_K += 1
			if atendado_nova_K < nivelo*10+80:
				Ondo.set_scale(Vector2(atendado_nova_K/20.0, atendado_nova_K/20.0))
				Ondo.set_opacity(Ondo.get_opacity()-0.008)
				if Ondo.get_opacity() < 0:
					Ondo.set_opacity(0)
			else:
				atendado_nova_K = 0
				Ondo.set_scale(Vector2(1, 1))
				Ondo.set_opacity(1.0)
	else:
		atendado_nova_K = 0
		Ondo.set_scale(Vector2(1, 1))
		Ondo.set_opacity(1)
	if get_tree().get_root().get_node("Radiko").kaptitajxo == self:
		set_global_pos(get_global_mouse_pos())
		Elektumo.show()
	else:
		Elektumo.hide()
	
	Nivelo.set_text(str(nivelo))
	
func _on_Kanono_input_event( viewport, event, shape_idx ):
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

func _on_Ondo_body_enter( korpo ):
	if korpo.get_name() == "Malamiko_0":
		korpo.get_parent().vivo -= nivelo*5

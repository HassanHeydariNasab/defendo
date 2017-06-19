extends Node2D

var Malamikoj = []

onready var F = get_node("Fiksata")
onready var P = get_node("Ondilo")
onready var Elektumo = get_node("Ondilo/Elektumo")
onready var Ondo = get_node("Ondo")
onready var Nivelo = get_node("Nivelo")
onready var Areo = get_node("Area2D")
onready var Limo = get_node("Area2D/Limo")
onready var Radiko = get_tree().get_root().get_node("Radiko")
onready var Enreta = get_node("Ondilo/Enreta")
onready var Fajro = get_node("Fajro")

var atendado_nova_K = 0
var nivelo = 1
var enreta = false

func _ready():
	Enreta.hide()
	set_process(true)

func _on_Area2D_body_enter( korpo ):
	if korpo.get_name() == "Malamiko_0":
		Malamikoj.push_front(korpo)

func _on_Area2D_body_exit( korpo ):
	if korpo.get_name() == "Malamiko_0":
		Malamikoj.remove(Malamikoj.find(korpo))
	
func _process(delta):
	if enreta:
		Enreta.show()
	else:
		Enreta.hide()
	if Malamikoj.size() > 0 and enreta:
		if Ondo.get_scale() == Vector2(1, 1):
			Radiko.mono -= 1
			Fajro.play()
		#se la malamiko liberigxis
		for Malamiko in Malamikoj:
			if not weakref(Malamiko).get_ref():
				Malamikoj.erase(Malamiko)
		if Malamikoj.size() > 0:
			var Malamiko = Malamikoj[0]
			atendado_nova_K += 1
			if atendado_nova_K < nivelo*5+80:
				Ondo.set_scale(Vector2(atendado_nova_K/20.0, atendado_nova_K/20.0))
				Ondo.set_opacity(Ondo.get_opacity()-0.007)
				if Ondo.get_opacity() < 0:
					Ondo.set_opacity(0)
			else:
				atendado_nova_K = 0
				Ondo.set_scale(Vector2(0.8, 0.8))
				Ondo.set_opacity(1.0)
	else:
		atendado_nova_K = 0
		Ondo.set_scale(Vector2(0.8, 0.8))
		Ondo.set_opacity(1)
	if Radiko.kaptitajxo == self:
		set_global_pos(get_global_mouse_pos())
		Elektumo.show()
		Limo.show()
	else:
		Elektumo.hide()
		Limo.hide()
	
	Nivelo.set_text(str(nivelo))
	Areo.set_scale(Vector2(log(nivelo)/5.0+1,log(nivelo)/5.0+1))
	
func _on_Kanono_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			Radiko.kaptitajxo = self
		else:
			Radiko.kaptitajxo = null
	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.button_mask == 0:
			Radiko.kaptitajxo = self
		else:
			Radiko.kaptitajxo = null

func _on_Ondo_body_enter( korpo ):
	if korpo.get_name() == "Malamiko_0" and enreta:
		korpo.get_parent().vivo -= nivelo*5

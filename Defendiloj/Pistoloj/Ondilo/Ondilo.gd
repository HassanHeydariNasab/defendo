extends Node2D

var Malamikoj = []

onready var F = get_node("Fiksata")
onready var P = get_node("Ondilo")
onready var Elektumo = get_node("Elektumo")
onready var Ondo = get_node("Ondo")
onready var Nivelo = get_node("Nivelo")
onready var Areo = get_node("Area2D")
onready var Limo = get_node("Area2D/Limo")
onready var Radiko = get_tree().get_root().get_node("Radiko")
onready var Enreta = get_node("Ondilo/Enreta")
onready var Fajro = get_node("Fajro")
onready var Agordejo = get_node("/root/Radiko").Agordejo

var atendado_nova_K = 0
var nivelo = 1
var enreta = false

func _ready():
	Enreta.hide()
	set_process(true)

func _on_Area2D_body_enter( korpo ):
	if korpo.get_name() == "Malamiko":
		Malamikoj.push_front(korpo)

func _on_Area2D_body_exit( korpo ):
	if korpo.get_name() == "Malamiko":
		Malamikoj.remove(Malamikoj.find(korpo))
	
func _process(delta):
	if enreta:
		Enreta.show()
	else:
		Enreta.hide()
	if Malamikoj.size() > 0 and enreta and Radiko.mono >= 5:
		if Ondo.get_scale() == Vector2(1, 1):
			Radiko.mono -= 5
			if Radiko.mono <= 0:
				get_node("/root/Radiko/Kanvaso/Vere_dauxrigi").popup()
			Fajro.set("stream/play", Agordejo.get_value("Agordoj", "Sonoj", true))
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
		set_global_scale(Vector2(0.35, 0.35))
		Elektumo.show()
		Limo.show()
	else:
		set_global_scale(Vector2(0.3, 0.3))
		Elektumo.hide()
		Limo.hide()
	
	Nivelo.set_text(str(nivelo))
	Areo.set_scale(Vector2(log(nivelo)/5.0+1,log(nivelo)/5.0+1))
	
func _on_Reta_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			Radiko.kaptitajxo = self
		else:
			Radiko.kaptitajxo = null

	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				Radiko.kaptitajxo = self
			else:
				Radiko.kaptitajxo = null

func _on_Ondo_body_enter( korpo ):
	if korpo.get_name() == "Malamiko" and enreta:
		var nova_rapido = korpo.get_parent().komenca_rapido*(((nivelo+18.0)/(nivelo+10.0))-0.75)
		if korpo.get_parent().rapido > nova_rapido:
			korpo.get_parent().rapido = nova_rapido
		if korpo.tipo == 2:
			korpo.get_parent().vivo -= log(nivelo+5)*70-80
		else:
			korpo.get_parent().vivo -= log(nivelo+5)*50-60
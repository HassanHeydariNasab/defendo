extends Node2D

var Malamikoj = []
var Malamikoj_kolizitaj = []

onready var F = get_node("Fiksata")
onready var P = get_node("Kanono")
onready var Kuglujo = get_node("Kanono/Kuglujo")
onready var Elektumo = get_node("Kanono/Elektumo")
onready var Nivelo = get_node("Nivelo")
onready var Areo = get_node("Area2D")
onready var Limo = get_node("Area2D/Limo")
onready var K = preload("res://Defendiloj/Kugloj/Kuglo/Kuglo.tscn")
onready var Strategio = get_node("Strategio")
onready var DK = get_node("DuoblaKlako")
onready var Radiko = get_tree().get_root().get_node("Radiko")


var nk = 0
var atendado_nova_K = 0
var nivelo = 1
var strategio = 'nova'
var enreta = false

func _ready():
	Strategio.hide()
	set_process(true)

func _on_Area2D_body_enter( korpo ):
	if korpo.get_name() == "Malamiko_0":
		Malamikoj.push_back(korpo)

func _on_Area2D_body_exit( korpo ):
	if korpo.get_name() == "Malamiko_0":
		Malamikoj.remove(Malamikoj.find(korpo))
	
func _process(delta):
	if Malamikoj_kolizitaj.size() > 0:
		for Mk in Malamikoj_kolizitaj:
			if not weakref(Mk).get_ref():
				Malamikoj_kolizitaj.erase(Mk)
	if Malamikoj.size() > 0:
		#se la malamiko liberigxis
		for Malamiko in Malamikoj:
			if not weakref(Malamiko).get_ref():
				Malamikoj.erase(Malamiko)
		if Malamikoj.size() > 0 and Malamikoj_kolizitaj.size() == 0 and enreta:
			var Malamiko = Malamikoj[0]
			if strategio == 'nova':
				Malamiko = Malamikoj[-1]
			elif strategio == 'malnova':
				Malamiko = Malamikoj[0]
			elif strategio == 'forta':
				for M in Malamikoj:
					if M.get_parent().vivo > Malamiko.get_parent().vivo:
						Malamiko = M
			elif strategio == 'malforta':
				for M in Malamikoj:
					if M.get_parent().vivo < Malamiko.get_parent().vivo:
						Malamiko = M
			
			else:
				Malamiko = Malamikoj[-1]
			var angulo = get_angle_to(Malamiko.get_global_pos())
			angulo -= deg2rad(180)
			P.set_rot(angulo)
			atendado_nova_K += 1
			if atendado_nova_K < 100 and atendado_nova_K % 10 == 0:
				var K_ = K.instance()
				K_.pistolo = self
				K_.nivelo = nivelo
				K_.angulo = angulo
				K_.set_global_pos(Kuglujo.get_global_pos())
				K_.set_global_scale(Vector2(log(nivelo)+1.0, log(nivelo)+1.0))
				get_tree().get_root().get_node("Radiko/Kugloj").add_child(K_)
			elif atendado_nova_K >= 100:
				atendado_nova_K = 0
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
			nk += 1
			DK.start()
			Radiko.kaptitajxo = self
		else:
			Radiko.kaptitajxo = null
		if nk >= 2:
			if Strategio.is_hidden():
				Strategio.show()
			else:
				Strategio.hide()
			nk = 0
			DK.stop()
		
	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.doubleclick:
			if Strategio.is_hidden():
				Strategio.show()
			else:
				Strategio.hide()
		if event.button_mask == 0:
			Radiko.kaptitajxo = self
		else:
			Radiko.kaptitajxo = null

func _on_DuoblaKlako_timeout():
	nk = 0

func _on_MalForta_button_up():
	Strategio.hide()
	strategio = 'malforta'

func _on_Nova_button_up():
	Strategio.hide()
	strategio = 'nova'

func _on_MalNova_button_up():
	Strategio.hide()
	strategio = 'malnova'

func _on_Forta_button_up():
	Strategio.hide()
	strategio = 'forta'

func _on_Area2D_2_body_enter( korpo ):
	#if korpo.get_name() == 'Malamiko_0':
	Malamikoj_kolizitaj.append(korpo)

func _on_Area2D_2_body_exit( korpo ):
	Malamikoj_kolizitaj.erase(korpo)

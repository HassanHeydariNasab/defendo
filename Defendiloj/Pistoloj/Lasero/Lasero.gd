extends Node2D

var Malamikoj = []

onready var F = get_node("Fiksata")
onready var P = get_node("Lasero")
onready var Laserradiujo = get_node("Lasero/Laserradiujo")
onready var Elektumo = get_node("Elektumo")
onready var Nivelo = get_node("Nivelo")
onready var Areo = get_node("Area2D")
onready var Limo = get_node("Area2D/Limo")
onready var K = preload("res://Defendiloj/Kugloj/Laserradio/Laserradio.tscn")
onready var Strategio = get_node("Strategio")
onready var LongFrapeti = get_node("LongFrapeti")
onready var Radiko = get_tree().get_root().get_node("Radiko")
onready var Enreta = get_node("Lasero/Enreta")
onready var Fajro = get_node("Fajro")
onready var Agordejo = get_node("/root/Radiko").Agordejo

var Kugloj


var nk = 0
var atendado_nova_K = 0
var nivelo = 1
var strategio = 'nova'
var enreta = false

func _ready():
	Kugloj = get_tree().get_root().get_node("Radiko/Kugloj")
	Strategio.hide()
	Enreta.hide()
	set_process(true)

func _on_Area2D_body_enter( korpo ):
	if korpo.get_name() == "Malamiko":
		Malamikoj.push_back(korpo)

func _on_Area2D_body_exit( korpo ):
	if korpo.get_name() == "Malamiko":
		Malamikoj.remove(Malamikoj.find(korpo))
	
func _process(delta):
	if enreta:
		Enreta.show()
	else:
		Enreta.hide()
	if Malamikoj.size() > 0:
		#se malamiko liberigxis
		for Malamiko in Malamikoj:
			if not weakref(Malamiko).get_ref():
				Malamikoj.erase(Malamiko)
		#se ankoraux ni havas malamikojn
		if Malamikoj.size() > 0 and enreta and Radiko.mono >= 5:
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
			if atendado_nova_K < 100 and atendado_nova_K % 50 == 0:
				Fajro.set("stream/play", Agordejo.get_value("Agordoj", "Sonoj", true))
				Radiko.mono -= 5
				if Radiko.mono <= 0:
					get_node("/root/Radiko/Kanvaso/Vere_dauxrigi").popup()
				var K_ = K.instance()
				K_.pistolo = self
				K_.nivelo = nivelo
				K_.angulo = angulo
				K_.set_global_pos(Laserradiujo.get_global_pos())
				#K_.set_global_scale(Vector2(log(nivelo)+1.0, log(nivelo)+1.0))
				Kugloj.add_child(K_)
			elif atendado_nova_K >= 100:
				atendado_nova_K = 0
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
	if event.type == InputEvent.SCREEN_DRAG:
		LongFrapeti.stop()
	elif event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			Strategio.hide()
			LongFrapeti.start()
			Radiko.kaptitajxo = self
		else:
			LongFrapeti.stop()
			Radiko.kaptitajxo = null

	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.button_index == BUTTON_RIGHT and event.is_pressed():
			if Strategio.is_hidden():
				Strategio.show()
			else:
				Strategio.hide()
		if event.button_index == BUTTON_LEFT:
			if event.is_pressed():
				Radiko.kaptitajxo = self
			else:
				Radiko.kaptitajxo = null

func _on_LongFrapeti_timeout():
	Strategio.show()

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

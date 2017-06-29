extends Node2D

var kaptitajxo = null
var vivo = 999
var Pistoloj = []
var mono = 350
var ondo = 1
var subondo = 0
var subondo_kreita = false
var sekva_ondo_permesita = true
var reto = 0

onready var Kamero = get_node("Kamero")
onready var Mono = get_node("Kanvaso/Mono")
onready var Ondo = get_node("Kanvaso/Ondo")
onready var Kanono = preload("res://Defendiloj/Pistoloj/Kanono/Kanono.tscn")
onready var Ondilo = preload("res://Defendiloj/Pistoloj/Ondilo/Ondilo.tscn")
onready var M0 = preload("res://Malamikoj/Malamiko_0_.tscn")
onready var M1 = preload("res://Malamikoj/Malamiko_1_.tscn")
onready var M2 = preload("res://Malamikoj/Malamiko_2_.tscn")
onready var Mj = get_node("Malamikoj")
onready var Pj = get_node("Pistoloj")
onready var Vivo = get_node("Bazo/Vivo")
onready var Sekva_ondo = get_node("Kanvaso/Ondo/Sekva_ondo")
onready var Batita = get_node("Bazo/Batita")
onready var iru_al_sekva_ondo = get_node("Kanvaso/iru_al_sekva_ondo")
onready var vastigu_la_reton = get_node("Kanvaso/vastigu_la_reton")
onready var Atendado_subondoj = get_node("Atendado_subondoj")
onready var Bazo = get_node("Bazo")
onready var Kanvaso = get_node("Kanvaso")


var tipoj = []
var ondoj = []

func _ready():
	get_tree().set_auto_accept_quit(false)
	tipoj = [
	{'sceno': M0, 'grando': 0.3, 'vivo': 40, 'rapido': 3.2},
	{'sceno': M0, 'grando': 0.45, 'vivo': 300, 'rapido': 2.8},
	{'sceno': M0, 'grando': 0.7, 'vivo': 800, 'rapido': 2.2},
	{'sceno': M1, 'grando': 0.8, 'vivo': 2000, 'rapido': 0.7},
	{'sceno': M2, 'grando': 0.45, 'vivo': 200, 'rapido': 1}
	]
	ondoj = [
	#0
	[{'nombro': 1, 'tipo': 0, 'atendo': 10},
	 {'nombro': 1, 'tipo': 0, 'atendo': 1},
	 {'nombro': 1, 'tipo': 0, 'atendo': 1},
	 {'nombro': 1, 'tipo': 0, 'atendo': 1},
	 {'nombro': 1, 'tipo': 0, 'atendo': 7},
	 {'nombro': 2, 'tipo': 0, 'atendo': 8},
	 {'nombro': 3, 'tipo': 0, 'atendo': 99}],
	#1
	[{'nombro': 3, 'tipo': 0, 'atendo': 5},
	 {'nombro': 1, 'tipo': 0, 'atendo': 7},
	 {'nombro': 5, 'tipo': 0, 'atendo': 8},
	 {'nombro': 7, 'tipo': 0, 'atendo': 10},
	 {'nombro': 1, 'tipo': 1, 'atendo': 99}],
	#2
	[{'nombro': 4, 'tipo': 0, 'atendo': 2},
	 {'nombro': 1, 'tipo': 0, 'atendo': 6},
	 {'nombro': 9, 'tipo': 0, 'atendo': 5},
	 {'nombro': 3, 'tipo': 1, 'atendo': 12},
	 {'nombro': 1, 'tipo': 2, 'atendo': 99}],
	#3
	[{'nombro': 1, 'tipo': 1, 'atendo': 6},
	 {'nombro': 5, 'tipo': 0, 'atendo': 5},
	 {'nombro': 3, 'tipo': 1, 'atendo': 10},
	 {'nombro': 3, 'tipo': 0, 'atendo': 2},
	 {'nombro': 3, 'tipo': 0, 'atendo': 2},
	 {'nombro': 3, 'tipo': 0, 'atendo': 7},
	 {'nombro': 1, 'tipo': 2, 'atendo': 4},
	 {'nombro': 1, 'tipo': 2, 'atendo': 4},
	 {'nombro': 1, 'tipo': 2, 'atendo': 99}],
	#4
	[{'nombro': 1, 'tipo': 2, 'atendo': 12},
	 {'nombro': 7, 'tipo': 0, 'atendo': 7},
	 {'nombro': 1, 'tipo': 3, 'atendo': 15},
	 {'nombro': 5, 'tipo': 1, 'atendo': 10},
	 {'nombro': 5, 'tipo': 0, 'atendo': 5},
	 {'nombro': 3, 'tipo': 0, 'atendo': 8},
	 {'nombro': 1, 'tipo': 4, 'atendo': 12}],
	#5
	[{'nombro': 1, 'tipo': 0, 'atendo': 2},
	 {'nombro': 1, 'tipo': 0, 'atendo': 2},
	 {'nombro': 1, 'tipo': 0, 'atendo': 2},
	 {'nombro': 1, 'tipo': 0, 'atendo': 2},
	 {'nombro': 1, 'tipo': 0, 'atendo': 2},
	 {'nombro': 1, 'tipo': 0, 'atendo': 2},
	 {'nombro': 1, 'tipo': 0, 'atendo': 2},
	 {'nombro': 1, 'tipo': 2, 'atendo': 11},
	 {'nombro': 1, 'tipo': 2, 'atendo': 15},
	 {'nombro': 3, 'tipo': 0, 'atendo': 2},
	 {'nombro': 1, 'tipo': 3, 'atendo': 20},
	 {'nombro': 3, 'tipo': 0, 'atendo': 7},
	 {'nombro': 1, 'tipo': 3, 'atendo': 15},
	 {'nombro': 1, 'tipo': 3, 'atendo': 15},
	 {'nombro': 1, 'tipo': 3, 'atendo': 99}],
	#6
	[{'nombro': 1, 'tipo': 1, 'atendo': 5},
	 {'nombro': 1, 'tipo': 1, 'atendo': 5},
	 {'nombro': 1, 'tipo': 1, 'atendo': 10},
	 {'nombro': 2, 'tipo': 2, 'atendo': 20},
	 {'nombro': 1, 'tipo': 3, 'atendo': 20},
	 {'nombro': 3, 'tipo': 0, 'atendo': 10},
	 {'nombro': 2, 'tipo': 4, 'atendo': 99}],
	]
	set_process(true)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_node("Kanvaso/Vere_eliri").popup()

func reanimi_ondo_teksto():
	Sekva_ondo.remove_all()
	Sekva_ondo.interpolate_property(Ondo, 'rect/scale', Vector2(1, 1),
		Vector2(1.5, 1.5), 0.4, Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	Sekva_ondo.interpolate_property(Ondo, 'rect/scale', Vector2(1.5, 1.5),
		Vector2(1, 1), 0.4, Tween.TRANS_QUAD, Tween.EASE_OUT, 0.4
	)
	Sekva_ondo.start()

func subondi(ondo_i, subondo_i):
	Atendado_subondoj.set_wait_time(ondoj[ondo_i][subondo_i]['atendo'])
	Atendado_subondoj.start()
	var subondo = ondoj[ondo_i][subondo_i]
	randomize()
	var hazardo = rand_range(-50.0, 100.0)
	for i in range(subondo['nombro']):
		var M_ = tipoj[subondo['tipo']]['sceno'].instance()
		if subondo['nombro'] == 1:
			M_.set_global_pos(Vector2(rand_range(0.0, 800.0), -2200))
		else:
			M_.set_global_pos(Vector2(-subondo['nombro']*200+i*tipoj[subondo['tipo']]['grando']*2000+hazardo, -2200))
		M_.set_scale(Vector2(tipoj[subondo['tipo']]['grando'], tipoj[subondo['tipo']]['grando']))
		M_.vivo = tipoj[subondo['tipo']]['vivo']
		M_.komenca_vivo = float(tipoj[subondo['tipo']]['vivo'])
		M_.rapido = tipoj[subondo['tipo']]['rapido']
		M_.komenca_rapido = tipoj[subondo['tipo']]['rapido']
		Mj.add_child(M_)
	subondo_kreita = true

func _process(delta):
	get_node("Kanvaso/FPS").set_text(str(int(1.0/delta)))
	if vivo <= 0 or mono < 0:
		Tutmonda.poentaro = ondo
		get_tree().change_scene("res://Kontroloj/Malvenkigxi.tscn")
	Mono.set_text(str(mono))
	Ondo.set_text(str(ondo))
	Vivo.set_text(str(vivo))
	if not subondo_kreita:
		subondi(ondo, subondo)
	# se la lasta subondo de ondo forigxis
	if Mj.get_child_count() == 0 and subondo == ondoj[ondo].size()-1:
		sekva_ondo_permesita = true
		iru_al_sekva_ondo.show()
		if weakref(vastigu_la_reton).get_ref():
			vastigu_la_reton.show()


func _on_Area2D_body_enter( korpo ):
	if korpo.get_name() == "Kanono" or korpo.get_name() == "Ondilo":
		Pistoloj.append(korpo)
	if Pistoloj.size() == 2:
		if Pistoloj[0].get_name() == "Kanono" and Pistoloj[1].get_name() == "Kanono":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()
		elif Pistoloj[0].get_name() == "Ondilo" and Pistoloj[1].get_name() == "Ondilo":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()

func _on_Area2D_body_exit( korpo ):
	if korpo.get_name() == "Kanono" or korpo.get_name() == "Ondilo":
		Pistoloj.erase(korpo)

func _on_Aldoni_Kanonon_pressed():
	if mono >= 10:
		mono -= 10
		var Kanono_ = Kanono.instance()
		Kanono_.set_global_pos(Vector2(540, 1040))
		Pj.add_child(Kanono_)

func _on_Aldoni_Ondilo_pressed():
	if mono >= 20:
		mono -= 20
		var Ondilo_ = Ondilo.instance()
		Ondilo_.set_global_pos(Vector2(250, 1040))
		Pj.add_child(Ondilo_)

func _je_malamiko_mortigxis(komenca_vivo):
	mono += int(komenca_vivo/8)+10

func _je_malamiko_batis_bazon(komenca_vivo):
	Batita.play()
	vivo -= int(komenca_vivo/4)

func _on_Atendado_subondoj_timeout():
	if subondo < ondoj[ondo].size()-1:
		subondo += 1
		subondo_kreita = false
		#print("sekva subondo: ", subondo)

func _on_Sekva_ondo_pressed():
	if sekva_ondo_permesita:
		iru_al_sekva_ondo.hide()
		if weakref(vastigu_la_reton).get_ref():
			vastigu_la_reton.hide()
		ondo += 1
		if ondo > ondoj.size()-1:
			Tutmonda.poentaro = ondo
			get_tree().change_scene("res://Kontroloj/Venkigxi.tscn")
		reanimi_ondo_teksto()
		subondo = 0
		subondo_kreita = false
		Atendado_subondoj.start()

func _on_Eliri_pressed():
	get_tree().quit()

func _on_Ludi_pressed():
	get_node("Kanvaso/Vere_eliri").hide()


func _on_Zomilo_value_changed( valoro ):
	Kamero.set_zoom(Vector2(valoro, valoro))
	Kamero.set_offset(Vector2(0,
	600-(Kamero.get_zoom().y)*600
	))

func _on_vastigu_la_reton_pressed():
	var prezoj = [500, 750, 900, 1200]
	if reto == 0 and mono > prezoj[0]:
		mono -= prezoj[0]
		get_node("Reto/N1").show()
		get_node("Kanvaso/vastigu_la_reton/Prezo").set_text(str(prezoj[1]))
		reto = 1
	elif reto == 1 and mono > prezoj[1]:
		mono -= prezoj[1]
		get_node("Reto/N2").show()
		get_node("Kanvaso/vastigu_la_reton/Prezo").set_text(str(prezoj[2]))
		reto = 2
	elif reto == 2 and mono > prezoj[2]:
		mono -= prezoj[2]
		get_node("Reto/N3").show()
		get_node("Kanvaso/vastigu_la_reton/Prezo").set_text(str(prezoj[3]))
		reto = 3
	elif reto == 3 and mono > prezoj[3]:
		mono -= prezoj[3]
		vastigu_la_reton.queue_free()
		get_node("Reto/N4").show()
		reto = 4

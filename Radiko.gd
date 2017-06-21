extends Node2D

var kaptitajxo = null
var vivo = 999
var Pistoloj = []
var mono = 350
var ondo = 0
var subondo = 0
var subondo_kreita = false
var sekva_ondo_permesita = true

onready var Mono = get_node("Mono")
onready var Ondo = get_node("Ondo")
onready var Kanono = preload("res://Defendiloj/Pistoloj/Kanono/Kanono.tscn")
onready var Ondilo = preload("res://Defendiloj/Pistoloj/Ondilo/Ondilo.tscn")
onready var M0 = preload("res://Malamikoj/Malamiko_0_.tscn")
onready var M1 = preload("res://Malamikoj/Malamiko_1_.tscn")
onready var M2 = preload("res://Malamikoj/Malamiko_2_.tscn")
onready var Mj = get_node("Malamikoj")
onready var Pj = get_node("Pistoloj")
onready var Vivo = get_node("Bazo/Vivo")
onready var Sekva_ondo = get_node("Ondo/Sekva_ondo")
onready var Batita = get_node("Bazo/Batita")
onready var iru_al_sekva_ondo = get_node("iru_al_sekva_ondo")
onready var Atendado_subondoj = get_node("Atendado_subondoj")

var tipoj = []
var ondoj = []

func _ready():
	tipoj = [
	{'sceno': M0, 'grando': 0.3, 'vivo': 20, 'rapido': 3},
	{'sceno': M0, 'grando': 0.45, 'vivo': 100, 'rapido': 1.5},
	{'sceno': M0, 'grando': 0.7, 'vivo': 400, 'rapido': 0.7},
	{'sceno': M1, 'grando': 0.45, 'vivo': 600, 'rapido': 1},
	{'sceno': M2, 'grando': 0.45, 'vivo': 250, 'rapido': 1}
	]
	ondoj = [
	[{'nombro': 1, 'tipo': 0, 'atendo': 10},
	 {'nombro': 1, 'tipo': 0, 'atendo': 1},
	 {'nombro': 1, 'tipo': 0, 'atendo': 1},
	 {'nombro': 1, 'tipo': 0, 'atendo': 1},
	 {'nombro': 1, 'tipo': 0, 'atendo': 7},
	 {'nombro': 2, 'tipo': 0, 'atendo': 8},
	 {'nombro': 3, 'tipo': 0, 'atendo': 99}],
	[{'nombro': 2, 'tipo': 0, 'atendo': 5},
	 {'nombro': 1, 'tipo': 0, 'atendo': 5},
	 {'nombro': 3, 'tipo': 0, 'atendo': 1},
	 {'nombro': 3, 'tipo': 0, 'atendo': 10},
	 {'nombro': 1, 'tipo': 1, 'atendo': 12}],
	[{'nombro': 2, 'tipo': 1, 'atendo': 3},
	 {'nombro': 5, 'tipo': 0, 'atendo': 7},
	 {'nombro': 1, 'tipo': 2, 'atendo': 12},
	 {'nombro': 3, 'tipo': 0, 'atendo': 2},
	 {'nombro': 3, 'tipo': 0, 'atendo': 2},
	 {'nombro': 3, 'tipo': 0, 'atendo': 10},
	 {'nombro': 3, 'tipo': 3, 'atendo': 12}],
	[{'nombro': 3, 'tipo': 3, 'atendo': 5},
	 {'nombro': 5, 'tipo': 0, 'atendo': 7},
	 {'nombro': 1, 'tipo': 4, 'atendo': 12},
	 {'nombro': 3, 'tipo': 0, 'atendo': 2},
	 {'nombro': 3, 'tipo': 1, 'atendo': 5},
	 {'nombro': 3, 'tipo': 0, 'atendo': 10},
	 {'nombro': 3, 'tipo': 4, 'atendo': 12}],
	[{'nombro': 3, 'tipo': 1, 'atendo': 5},
	 {'nombro': 5, 'tipo': 2, 'atendo': 7},
	 {'nombro': 1, 'tipo': 4, 'atendo': 12},
	 {'nombro': 7, 'tipo': 0, 'atendo': 2},
	 {'nombro': 3, 'tipo': 3, 'atendo': 10},
	 {'nombro': 3, 'tipo': 0, 'atendo': 3},
	 {'nombro': 3, 'tipo': 4, 'atendo': 12}],
	]
	set_process(true)

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
	for i in range(subondo['nombro']):
		var M_ = tipoj[subondo['tipo']]['sceno'].instance()
		if subondo['nombro'] == 1:
			M_.set_global_pos(Vector2(rand_range(0.0, 640.0), -100))
		else:
			M_.set_global_pos(Vector2(-subondo['nombro']*20+i*300+rand_range(-100.0, 100.0), -250))
		M_.set_scale(Vector2(tipoj[subondo['tipo']]['grando'], tipoj[subondo['tipo']]['grando']))
		M_.vivo = tipoj[subondo['tipo']]['vivo']
		M_.komenca_vivo = float(tipoj[subondo['tipo']]['vivo'])
		M_.rapido = tipoj[subondo['tipo']]['rapido']
		Mj.add_child(M_)
	subondo_kreita = true
	
func _process(delta):
	if vivo <= 0 or mono < 0:
		Tutmonda.poentaro = int(mono+vivo+ondo*7)
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
		Kanono_.set_global_pos(Vector2(480, 800))
		Pj.add_child(Kanono_)

func _on_Aldoni_Ondilo_pressed():
	if mono >= 20:
		mono -= 20
		var Ondilo_ = Ondilo.instance()
		Ondilo_.set_global_pos(Vector2(180, 800))
		Pj.add_child(Ondilo_)

func _je_malamiko_mortigxis(komenca_vivo):
	mono += int(komenca_vivo/10)+10

func _je_malamiko_batis_bazon(komenca_vivo):
	Batita.play()
	vivo -= int(komenca_vivo/10)

func _on_Atendado_subondoj_timeout():
	if subondo < ondoj[ondo].size()-1:
		subondo += 1
		subondo_kreita = false
		#print("sekva subondo: ", subondo)

func _on_Sekva_ondo_pressed():
	if sekva_ondo_permesita:
		iru_al_sekva_ondo.hide()
		ondo += 1
		if ondo > ondoj.size()-1:
			Tutmonda.poentaro = int(mono+vivo+ondo*7)
			get_tree().change_scene("res://Kontroloj/Venkigxi.tscn")
		reanimi_ondo_teksto()
		subondo = 0
		subondo_kreita = false
		Atendado_subondoj.start()

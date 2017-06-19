extends Node2D

var kaptitajxo = null
var vivo = 999
var Pistoloj = []
var mono = 350
var ondo = 0
var subondo = 0
var subondo_kreita = false

onready var Mono = get_node("Mono")
onready var Ondo = get_node("Ondo")
onready var Kanono = preload("res://Defendiloj/Pistoloj/Kanono/Kanono.tscn")
onready var Ondilo = preload("res://Defendiloj/Pistoloj/Ondilo/Ondilo.tscn")
onready var M0 = preload("res://Malamikoj/Malamiko_0_.tscn")
onready var Mj = get_node("Malamikoj")
onready var Pj = get_node("Pistoloj")
onready var Vivo = get_node("Bazo/Vivo")
onready var Sekva_ondo = get_node("Ondo/Sekva_ondo")

var tipoj = []
var ondoj = []

func _ready():
	tipoj = [
	{'sceno': M0, 'grando': 0.4, 'vivo': 99, 'rapido': 2},
	{'sceno': M0, 'grando': 0.7, 'vivo': 999, 'rapido': 0.7},
	]
	ondoj = [
	[{'nombro': 1, 'tipo': 0}],
	[{'nombro': 3, 'tipo': 0}],
	[{'nombro': 3, 'tipo': 0}, {'nombro': 3, 'tipo': 0}],
	[{'nombro': 4, 'tipo': 0}, {'nombro': 1, 'tipo': 0}, {'nombro': 1, 'tipo': 1}],
	[{'nombro': 3, 'tipo': 0}, {'nombro': 4, 'tipo': 0}, {'nombro': 3, 'tipo': 0}, {'nombro': 4, 'tipo': 0}],
	[{'nombro': 7, 'tipo': 0}, {'nombro': 3, 'tipo': 0}, {'nombro': 2, 'tipo': 1}],
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
	# subondo estas tiel {'nombro': 5, 'tipo': 0}
	var subondo = ondoj[ondo_i][subondo_i]
	for i in range(subondo['nombro']):
		var M_ = tipoj[subondo['tipo']]['sceno'].instance()
		if subondo['nombro'] == 1:
			M_.set_global_pos(Vector2(310, -100))
		else:
			M_.set_global_pos(Vector2(-subondo['nombro']*50+i*300+50, -100))
		M_.set_scale(Vector2(tipoj[subondo['tipo']]['grando'], tipoj[subondo['tipo']]['grando']))
		M_.vivo = tipoj[subondo['tipo']]['vivo']
		M_.komenca_vivo = float(tipoj[subondo['tipo']]['vivo'])
		M_.rapido = tipoj[subondo['tipo']]['rapido']
		Mj.add_child(M_)
	subondo_kreita = true
	
func _process(delta):
	if vivo <= 0 or mono < 0:
		get_tree().change_scene("res://Kontroloj/Malvenkigxi.tscn")
	Mono.set_text(str(mono))
	Ondo.set_text(str(ondo))
	Vivo.set_text(str(vivo))
	if not subondo_kreita:
		subondi(ondo, subondo)
	# se la lasta subondo de ondo forigxis
	if Mj.get_child_count() == 0 and subondo == ondoj[ondo].size()-1:
		ondo += 1
		if ondo > ondoj.size()-1:
			get_tree().change_scene("res://Kontroloj/Venkigxi.tscn")
		reanimi_ondo_teksto()
		#Sekva_ondo.start()
		subondo = 0
		subondo_kreita = false
		get_node("Atendado_subondoj").start()
	
func _on_Area2D_body_enter( korpo ):
	Pistoloj.append(korpo)
	if Pistoloj.size() == 2:
		if Pistoloj[0].get_name() == "Kanono" and Pistoloj[1].get_name() == "Kanono":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()
		elif Pistoloj[0].get_name() == "Ondilo" and Pistoloj[1].get_name() == "Ondilo":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()
		elif Pistoloj[0].get_name() == "Lasero" and Pistoloj[1].get_name() == "Lasero":
			Pistoloj[0].get_parent().nivelo += Pistoloj[1].get_parent().nivelo
			Pistoloj[1].get_parent().queue_free()

func _on_Area2D_body_exit( korpo ):
	Pistoloj.erase(korpo)

func _on_Aldoni_Kanonon_button_up():
	if mono >= 10:
		mono -= 10
		var Kanono_ = Kanono.instance()
		Kanono_.set_global_pos(Vector2(480, 800))
		Pj.add_child(Kanono_)

func _on_Aldoni_Ondilo_button_up():
	if mono >= 20:
		mono -= 20
		var Ondilo_ = Ondilo.instance()
		Ondilo_.set_global_pos(Vector2(180, 800))
		Pj.add_child(Ondilo_)

func _je_malamiko_0_mortigxis(grando):
	mono += int(grando*10)+10

func _je_malamiko_0_batis_bazon(grando):
	vivo -= int(grando*10)

func _on_Atendado_subondoj_timeout():
	if subondo < ondoj[ondo].size()-1:
		subondo += 1
		subondo_kreita = false
		print("sekva subondo")

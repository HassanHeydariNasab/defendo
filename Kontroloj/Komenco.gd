extends Node2D

onready var Kasxi_enkondukon = get_node("Enkonduko/Kasxi_enkondukon")
onready var Kasxi_gvidilon = get_node("Gvidilo/Kasxi_gvidilon")
onready var Enkonduko = get_node("Enkonduko")
onready var Gvidilo = get_node("Gvidilo")

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

func _ready():
	Agordejo.load(agordejo)
	var lingvo_indekso = Agordejo.get_value("Lingvo", "lingvo")
	if lingvo_indekso == null:
		get_tree().change_scene("res://Kontroloj/Lingvo.tscn")
	elif TranslationServer.get_locale() != lingvoj[lingvo_indekso]:
		TranslationServer.set_locale(lingvoj[lingvo_indekso])
		get_tree().reload_current_scene()

	Kasxi_enkondukon.interpolate_property(Enkonduko,
	"visibility/opacity",1,0,0.6,
	Tween.TRANS_QUAD, Tween.EASE_OUT)
	Kasxi_enkondukon.interpolate_property(Enkonduko,
	"transform/pos",get_global_pos(),get_global_pos()+Vector2(0,-200),0.6,
	Tween.TRANS_QUAD, Tween.EASE_OUT)
	Kasxi_enkondukon.interpolate_property(Gvidilo,
	"visibility/opacity",0,1,0.6,
	Tween.TRANS_QUAD, Tween.EASE_OUT,1)
	Kasxi_enkondukon.interpolate_property(Gvidilo,
	"transform/pos",Gvidilo.get_global_pos()+Vector2(0,-200),Gvidilo.get_global_pos(),0.6,
	Tween.TRANS_QUAD, Tween.EASE_OUT,1)

	Kasxi_gvidilon.interpolate_property(Gvidilo,
	"visibility/opacity",1,0,0.6,
	Tween.TRANS_QUAD, Tween.EASE_OUT)

func _on_Akcepti_pressed():
	Kasxi_enkondukon.start()


func _on_Ludi_pressed():
	Kasxi_gvidilon.start()


func _on_Kasxi_gvidilon_tween_complete( object, key ):
	get_tree().change_scene("res://Radiko.tscn")


func _on_Lingvo_pressed():
	get_tree().change_scene("res://Kontroloj/Lingvo.tscn")

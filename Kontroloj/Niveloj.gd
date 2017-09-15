extends Control

onready var Fadi = get_node("Fadi")
onready var Nova_epoko_Rekordo = get_node("Nova_epoko/Rekordo")
onready var Malnova_epoko_Rekordo = get_node("Malnova_epoko/Rekordo")


var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

func _ready():
	get_tree().set_auto_accept_quit(true)
	Agordejo.load(agordejo)
	var lingvo_indekso = Agordejo.get_value("Lingvo", "lingvo")
	var nova_epoko_rekordo = Agordejo.get_value("Rekordoj", "nova_epoko")
	var malnova_epoko_rekordo = Agordejo.get_value("Rekordoj", "malnova_epoko")
	if lingvo_indekso == null or nova_epoko_rekordo == null or malnova_epoko_rekordo == null:
		Agordejo.set_value("Rekordoj", "nova_epoko", 0)
		Agordejo.set_value("Rekordoj", "malnova_epoko", 0)
		Agordejo.save(agordejo)
		get_tree().change_scene("res://Kontroloj/Lingvo.tscn")
	elif TranslationServer.get_locale() != lingvoj[lingvo_indekso]:
		TranslationServer.set_locale(lingvoj[lingvo_indekso])
		get_tree().reload_current_scene()
	Nova_epoko_Rekordo.set_text(str(nova_epoko_rekordo))
	Malnova_epoko_Rekordo.set_text(str(malnova_epoko_rekordo))

	Fadi.interpolate_property(self, "visibility/opacity",1,0,
		0.4, Tween.TRANS_QUAD, Tween.EASE_OUT
		)

func _on_Ludi_pressed():
	Tutmonda.epoko = "nova"
	Fadi.start()

func _on_Ludi_malnova_pressed():
	Tutmonda.epoko = "malnova"
	Fadi.start()

func _on_Fadi_tween_complete( object, key ):
	get_tree().change_scene("res://Radiko.tscn")

func _on_Lingvo_pressed():
	get_tree().change_scene("res://Kontroloj/Lingvo.tscn")

func _on_Gvidilo_pressed():
	get_tree().change_scene("res://Kontroloj/Gvidilo.tscn")

func _on_Pri_pressed():
	get_tree().change_scene("res://Kontroloj/Pri.tscn")

func _on_Agordoj_pressed():
	get_tree().change_scene("res://Kontroloj/Agordoj.tscn")
extends Control

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

func _ready():
	get_tree().set_auto_accept_quit(true)

	Agordejo.load(agordejo)
	var lingvo_indekso = Agordejo.get_value("Lingvo", "lingvo")
	if lingvo_indekso == null:
		get_tree().change_scene("res://Kontroloj/Lingvo.tscn")
	elif TranslationServer.get_locale() != lingvoj[lingvo_indekso]:
		TranslationServer.set_locale(lingvoj[lingvo_indekso])
		get_tree().reload_current_scene()

	get_node("Poentaro").set_text(str(Tutmonda.poentaro))
	if Tutmonda.epoko == "nova" and Tutmonda.poentaro > Agordejo.get_value("Rekordoj", "nova_epoko", 0):
		Agordejo.set_value("Rekordoj", "nova_epoko", Tutmonda.poentaro)
	elif Tutmonda.epoko == "malnova" and Tutmonda.poentaro > Agordejo.get_value("Rekordoj", "malnova_epoko", 0):
		Agordejo.set_value("Rekordoj", "malnova_epoko", Tutmonda.poentaro)
	Agordejo.save(agordejo)

func _on_Reen_pressed():
	get_tree().change_scene("res://Kontroloj/Niveloj.tscn")
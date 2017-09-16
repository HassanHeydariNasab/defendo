extends Control

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

func _ready():
	get_tree().set_auto_accept_quit(true)
	Agordejo.load(agordejo)
	get_node("Poentaro").set_text(str(Tutmonda.poentaro))
	if Tutmonda.poentaro == 1 or Tutmonda.poentaro == 0:
		get_node("Poentaro/Etikedo").set_text(tr("Ondo"))
	if Tutmonda.epoko == "nova" and Tutmonda.poentaro > Agordejo.get_value("Rekordoj", "nova_epoko", 0):
		Agordejo.set_value("Rekordoj", "nova_epoko", Tutmonda.poentaro)
	elif Tutmonda.epoko == "malnova" and Tutmonda.poentaro > Agordejo.get_value("Rekordoj", "malnova_epoko", 0):
		Agordejo.set_value("Rekordoj", "malnova_epoko", Tutmonda.poentaro)
	Agordejo.save(agordejo)

func _on_Reen_pressed():
	get_tree().change_scene("res://Kontroloj/Niveloj.tscn")
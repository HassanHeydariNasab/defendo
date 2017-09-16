extends Control

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

func _ready():
	get_tree().set_auto_accept_quit(false)
	Agordejo.load(agordejo)
	get_node("Poentaro").set_text(str(Tutmonda.poentaro))
	if Tutmonda.epoko == "nova":
		Agordejo.set_value("Rekordoj", "nova_epoko", Tutmonda.poentaro)
	elif Tutmonda.epoko == "malnova":
		Agordejo.set_value("Rekordoj", "malnova_epoko", Tutmonda.poentaro)
	Agordejo.save(agordejo)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Kontroloj/Niveloj.tscn")

func _on_Reen_pressed():
	get_tree().change_scene("res://Kontroloj/Niveloj.tscn")
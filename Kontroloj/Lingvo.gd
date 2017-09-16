extends Node2D

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

func _ready():
	get_tree().set_auto_accept_quit(false)
	Agordejo.load(agordejo)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST and Tutmonda.lingvo_elektita:
		get_tree().change_scene("res://Kontroloj/Niveloj.tscn")

func _on_EO_pressed():
	Agordejo.set_value("Lingvo", "lingvo", "eo")
	Agordejo.save(agordejo)
	Tutmonda.lingvo_elektita = true
	get_tree().change_scene("res://Kontroloj/Niveloj.tscn")

func _on_EN_pressed():
	Agordejo.set_value("Lingvo", "lingvo", "en")
	Agordejo.save(agordejo)
	Tutmonda.lingvo_elektita = true
	get_tree().change_scene("res://Kontroloj/Niveloj.tscn")

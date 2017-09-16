extends Node

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

func _ready():
	Agordejo.load(agordejo)
	if Agordejo.get_value("Lingvo", "lingvo", "") == "":
		Tutmonda.lingvo_elektita = false
		get_tree().change_scene("res://Kontroloj/Lingvo.tscn")
	else:
		Tutmonda.lingvo_elektita = true
		get_tree().change_scene("res://Kontroloj/Niveloj.tscn")
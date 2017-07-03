extends Node2D

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()
const lingvoj = ["eo", "en"]

func _ready():
	Agordejo.load(agordejo)

func _on_EO_pressed():
	Agordejo.set_value("Lingvo", "lingvo", 0)
	Agordejo.save(agordejo)
	get_tree().change_scene("res://Kontroloj/Komenco.tscn")

func _on_EN_pressed():
	Agordejo.set_value("Lingvo", "lingvo", 1)
	Agordejo.save(agordejo)
	get_tree().change_scene("res://Kontroloj/Komenco.tscn")

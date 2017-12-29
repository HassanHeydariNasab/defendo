extends Control

var agordejo = "user://agordejo.cfg"
onready var Agordejo = ConfigFile.new()

func _ready():
	get_tree().set_auto_accept_quit(false)
	Agordejo.load(agordejo)
	get_node("Sonoj").set_pressed(Agordejo.get_value("Agordoj", "Sonoj", true))
	get_node("Muzikoj").set_pressed(Agordejo.get_value("Agordoj", "Muzikoj", true))
	get_node("FPS").set_pressed(Agordejo.get_value("Agordoj", "FPS", false))
	
func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Kontroloj/Niveloj.tscn")

func _on_Sonoj_toggled( b ):
	Agordejo.set_value("Agordoj", "Sonoj", b)
	Agordejo.save(agordejo)

func _on_Muzikoj_toggled( b ):
	Agordejo.set_value("Agordoj", "Muzikoj", b)
	Agordejo.save(agordejo)
	
func _on_FPS_toggled( b ):
	Agordejo.set_value("Agordoj", "FPS", b)
	Agordejo.save(agordejo)

func _on_Reen_pressed():
	get_tree().change_scene("res://Kontroloj/Niveloj.tscn")
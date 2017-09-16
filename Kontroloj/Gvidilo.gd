extends Control

func _ready():
	get_tree().set_auto_accept_quit(false)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Kontroloj/Niveloj.tscn")

func _on_Reen_pressed():
	get_tree().change_scene("res://Kontroloj/Niveloj.tscn")
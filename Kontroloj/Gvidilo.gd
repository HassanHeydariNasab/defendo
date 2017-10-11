extends Control

func _ready():
	get_tree().set_auto_accept_quit(false)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		get_tree().change_scene("res://Kontroloj/Niveloj.tscn")

func _on_Reen_pressed():
	get_tree().change_scene("res://Kontroloj/Niveloj.tscn")

func _on_Fontkodo_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/defendo")

func _on_Atribuoj_pressed():
	OS.shell_open("https://github.com/HassanHeydariNasab/defendo/blob/master/ATRIBUOJ.md")

func _on_Donaci_pressed():
	OS.shell_open("bitcoin:16D7Nroenpx4QDNqfq3Js7sdAVhew2NzGp")
extends Node2D

onready var Fadi = get_node("Fadi")

func _ready():
	Fadi.interpolate_property(self, "visibility/opacity",1,0,
		0.4, Tween.TRANS_QUAD, Tween.EASE_OUT
		)

func _on_Ludi_pressed():
	Tutmonda.nivelo = 1
	Fadi.start()

func _on_Fadi_tween_complete( object, key ):
	get_tree().change_scene("res://Radiko.tscn")

func _on_Ludi_malnova_pressed():
	Tutmonda.nivelo = 0
	Fadi.start()
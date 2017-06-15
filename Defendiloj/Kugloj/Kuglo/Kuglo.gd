extends Node2D

var pistolo
var t = 0
var nivelo = 0
var angulo = 0

func _ready():
	if nivelo != 0 and angulo != 0:
		set_process(true)
		set_fixed_process(true)

func _fixed_process(delta):
	get_node("Kuglo").move((Vector2(4.0*(log(nivelo)+1.0)*cos(angulo), -4.0*(log(nivelo)+1.0)*sin(angulo))))

func _process(delta):
	if get_node("Kuglo").is_colliding():
		get_node("Kuglo").get_collider().get_parent().vivo -= nivelo
		queue_free()
		t += 10
	t += 1
	if t > 200:
		queue_free()
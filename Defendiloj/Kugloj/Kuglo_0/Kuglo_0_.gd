extends Node2D

var pistolo
var t = 0

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var Koliziaj = get_node("Kuglo_0").get_colliding_bodies()
	if Koliziaj.size() == 1:
		Koliziaj[0].get_parent().vivo -= 1
		t += 10
	t += 1
	get_node("Kuglo_0").set_scale(Vector2((100-t)/50,(100-t)/50))
	if t > 100:
		queue_free()
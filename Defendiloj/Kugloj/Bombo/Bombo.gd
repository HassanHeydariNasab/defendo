extends Node2D

var nivelo = 1
var enreta = false

onready var Radiko = get_tree().get_root().get_node("Radiko")
onready var Nivelo = get_node("Nivelo")
onready var Enreta = get_node("Enreta")


func _ready():
	set_process(true)

func _process(delta):
#	print(enreta)
	if enreta:
		Enreta.show()
	else:
		Enreta.hide()
	if Radiko.kaptitajxo == self:
		set_global_pos(get_global_mouse_pos())
		set_global_scale(Vector2(1.35, 1.35))
	else:
		set_global_scale(Vector2(1.3, 1.3))
	Nivelo.set_text(str(nivelo))

func _on_Reta_body_enter( korpo ):
	if korpo.get_name() == "Malamiko":
		if korpo.tipo == 0 or korpo.tipo == 1:
			korpo.get_parent().vivo -= log(nivelo+3)*40-45
			queue_free()


func _on_Reta_input_event( viewport, event, shape_idx ):
	if event.type == InputEvent.SCREEN_TOUCH:
		if event.pressed:
			Radiko.kaptitajxo = self
		else:
			Radiko.kaptitajxo = null

	elif event.type == InputEvent.MOUSE_BUTTON:
		if event.button_mask == 0:
			Radiko.kaptitajxo = self
		else:
			Radiko.kaptitajxo = null
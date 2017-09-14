extends Node2D

var nivelo = 1
var enreta = false

onready var Radiko = get_tree().get_root().get_node("Radiko")
onready var Nivelo = get_node("Nivelo")
onready var Enreta = get_node("Enreta")
onready var Eksplodi = get_node("Eksplodi")
onready var Eksplodsono = get_node("Eksplodsono")
onready var Tempilo = get_node("Tempilo")


func _ready():
	Eksplodi.interpolate_property(self, "transform/scale",
		Vector2(0.3,0.3),Vector2(0.5,0.5),0.3,
		Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	Eksplodi.interpolate_property(self, "visibility/opacity",
		1, 0, 0.3,Tween.TRANS_QUAD, Tween.EASE_OUT
	)
	set_process(true)

func _process(delta):
	if enreta:
		Enreta.show()
		if not Radiko.sekva_ondo_permesita:
			Tempilo.set_active(true)
		else:
			Tempilo.set_active(false)
	else:
		Enreta.hide()
		Tempilo.set_active(false)
	if Radiko.kaptitajxo == self:
		set_global_pos(get_global_mouse_pos())
		set_global_scale(Vector2(0.35, 0.35))
	else:
		set_global_scale(Vector2(0.3, 0.3))
	Nivelo.set_text(str(nivelo))

func _on_Reta_body_enter( korpo ):
	if korpo.get_name() == "Malamiko":
		if korpo.tipo == 0 or korpo.tipo == 1:
			korpo.get_parent().vivo -= log(nivelo+10)*200-450
			Eksplodsono.play()
			Eksplodi.start()


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

func _on_Eksplodi_tween_complete( object, key ):
	queue_free()


func _on_Tempilo_timeout():
	if nivelo < 99:
		nivelo += 1
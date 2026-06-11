extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_dialog"):
		if Global.cena_anterior != "":
			get_tree().change_scene_to_file(Global.cena_anterior)
		else:
			print("Teste concluido!")
			get_tree().quit()

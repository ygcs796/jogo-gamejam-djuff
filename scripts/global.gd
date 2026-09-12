extends Node

var cena_anterior := ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func go_home():
	MusicManager.player.volume_linear = 1
	get_tree().paused = false
	get_tree().change_scene_to_file("res://cenarios/title_screen.tscn")
	

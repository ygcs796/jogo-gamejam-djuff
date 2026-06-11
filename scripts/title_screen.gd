# title_screen.gd
extends CanvasLayer

signal start_game

@onready var continue_label: Label = $NarrationBox/MarginContainer/VBoxContainer/ContinueLabel

var blink_tween: Tween

func _ready():
	MusicManager.play(preload("res://audios/part1.ogg"))
	_start_blink()

func _start_blink():
	if blink_tween:
		blink_tween.kill()

	blink_tween = create_tween()
	blink_tween.set_loops()

	blink_tween.tween_property(
		continue_label,
		"modulate:a",
		0.0,
		1.2
	)

	blink_tween.tween_property(
		continue_label,
		"modulate:a",
		1.0,
		1.2
	)

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		if blink_tween:
			blink_tween.kill()
			
		emit_signal("start_game")
		get_tree().change_scene_to_file("res://cenarios/narration_screen.tscn")

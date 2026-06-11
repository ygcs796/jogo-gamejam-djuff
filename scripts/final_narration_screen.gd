# ending_screen.gd
extends CanvasLayer

@onready var narration_text: RichTextLabel = $FinalNarrationBox/MarginContainer/VBoxContainer/NarrationText
@onready var journey_label: Label = $FinalNarrationBox/MarginContainer/VBoxContainer/Journey

@export var typing_speed: float = 0.05

const FINAL_TEXT := """
As trilhas entre [color=yellow]Lumina[/color] e [color=purple]Umbra[/color] pareciam separadas por oceanos de distância devido à sua fratura. Não obstante, os caminhos [color=yellow]luminais[/color] se uniram às estradas vicinais [color=purple]umbrais[/color]. É uma dimensão paradoxal onde as duas realidades compartilharam a mesma passagem.

Dominar os fundamentos da travessia dimensional é um trajeto ardiloso, mas você coordenou os passos com maestria.

O sublime entre [color=yellow]Lumina[/color] e [color=purple]Umbra[/color] ainda está longe de ser restaurado, mas esta é uma jornada que termina para poder começar uma caminhada ainda maior.
"""

var is_typing := false
var current_tween: Tween

func _ready():
	MusicManager.play(preload("res://audios/part3.ogg"))
	journey_label.visible = false
	_type_text()

func _type_text():
	narration_text.text = FINAL_TEXT
	narration_text.visible_characters = 0

	is_typing = true

	if current_tween:
		current_tween.kill()

	current_tween = create_tween()
	current_tween.tween_method(
		func(value: int):
			narration_text.visible_characters = value,
		0,
		FINAL_TEXT.length(),
		FINAL_TEXT.length() * typing_speed
	)

	current_tween.tween_callback(func():
		is_typing = false
		journey_label.visible = true
	)

func _unhandled_input(event):
	if not visible:
		return

	if event.is_action_pressed("ui_accept"):
		if is_typing:
			if current_tween:
				current_tween.kill()

			narration_text.visible_characters = -1
			is_typing = false
			journey_label.visible = true

		else:
			_go_to_next_scene()

func _go_to_next_scene():
	get_tree().change_scene_to_file("res://cenarios/gratefulness_screen.tscn")

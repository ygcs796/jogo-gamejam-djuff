extends BaseNarration

@onready var _text_label = $FinalNarrationBox/MarginContainer/VBoxContainer/NarrationText
func _get_text_label() -> RichTextLabel:
	return _text_label

@onready var _continue_label = $FinalNarrationBox/MarginContainer/VBoxContainer/Journey
func _get_continue_label() -> Label:
	return _continue_label

var final_text := """
As trilhas entre [Lumina] e [Umbra] pareciam separadas por oceanos de distância devido à sua fratura. Não obstante, os caminhos [color=yellow]luminais[/color] se uniram às estradas vicinais [color=purple]umbrais[/color]. É uma dimensão paradoxal onde as duas realidades compartilharam a mesma passagem.

Dominar os fundamentos da travessia dimensional é um trajeto ardiloso, mas você coordenou os passos com maestria.

O sublime entre [Lumina] e [Umbra] ainda está longe de ser restaurado, mas esta é uma jornada que termina para poder começar uma caminhada ainda maior.
"""

func _ready():
	MusicManager.play(preload("res://audios/part3.ogg"))
	show_pages([final_text])

func _on_finished() -> void:
	get_tree().change_scene_to_file("res://cenarios/gratefulness_screen.tscn")

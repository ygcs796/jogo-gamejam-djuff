extends CanvasLayer

@onready var text_label: RichTextLabel = $GratefulnessBox/MarginContainer/VBoxContainer/NarrationText

@export var typing_speed: float = 0.03

var current_page := 0
var is_typing := false
var current_tween: Tween

var pages: Array[String] = [
"""Agradecemos imensamente por ter se imerso em nossa exploração entre os planos [color=yellow]Lumina[/color] e [color=purple]Umbra[/color]. Esta Vertical Slice foi criada como um vislumbre de um universo ainda maior, onde a Ruptura guarda segredos que ainda estão por ser revelados.

Embora esta jornada encerre aqui, muitos caminhos ainda permanecem ocultos, levando seus fluxos para outras direções.""",

"""A história entre [color=yellow]Lumina[/color] e [color=purple]Umbra[/color] está apenas começando, e isso foi apenas o primeiro passo rumo ao que ainda resta do espaço dimensional.
Character Design — [color=yellow]Emily Gomes[/color]
Narrative Design — [color=purple]Micaellen Lima[/color]
Visual Art — [color=yellow]Pedro Cruz[/color]
Technical Game Design — [color=purple]Vitor Câmara[/color]
Game Development — [color=yellow]Yuri Gabryel[/color]"""
]

func _ready():
	MusicManager.play(preload("res://audios/part2.ogg"))
	_show_page(0)

func _show_page(index: int):
	text_label.bbcode_enabled = true
	text_label.text = pages[index]
	text_label.visible_characters = 0
	is_typing = true

	if current_tween:
		current_tween.kill()

	current_tween = create_tween()
	current_tween.tween_method(
		func(value: int):
			text_label.visible_characters = value,
		0,
		pages[index].length(),
		pages[index].length() * typing_speed
	)

	current_tween.tween_callback(func():
		is_typing = false
	)

func _unhandled_input(event):
	if !visible:
		return

	if event.is_action_pressed("ui_accept"):
		if is_typing:
			if current_tween:
				current_tween.kill()

			text_label.visible_characters = -1
			is_typing = false
		else:
			_next_page()

func _next_page():
	current_page += 1

	if current_page < pages.size():
		_show_page(current_page)
	else:
		get_tree().change_scene_to_file("res://cenarios/title_screen.tscn")

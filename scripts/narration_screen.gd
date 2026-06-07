# narration_screen.gd
extends CanvasLayer

@onready var narration_text: RichTextLabel = $NarrationBox/MarginContainer/VBoxContainer/NarrationText
@onready var continue_label: Label = $NarrationBox/MarginContainer/VBoxContainer/ContinueLabel

@export var typing_speed: float = 0.05  # segundos por caractere

var pages: Array[String] = []
var current_page: int = 0
var is_typing: bool = false

func _ready():
	continue_label.visible = false

func show_narration(texts: Array[String]):
	pages = texts
	current_page = 0
	visible = true
	_type_page(pages[current_page])

func _type_page(text: String):
	narration_text.text = text
	narration_text.visible_characters = 0
	is_typing = true
	continue_label.visible = false

	var tween = create_tween()
	tween.tween_method(
		func(val: int): narration_text.visible_characters = val,
		0,
		len(text),
		len(text) * typing_speed
	)
	tween.tween_callback(func():
		is_typing = false
		continue_label.visible = true
	)

func _unhandled_input(event):
	if not visible:
		return
	if event.is_action_pressed("ui_accept"):
		if is_typing:
			# Pula direto pro fim do texto
			narration_text.visible_characters = -1
			is_typing = false
			continue_label.visible = true
		else:
			_next_page()

func _next_page():
	current_page += 1
	if current_page < pages.size():
		_type_page(pages[current_page])
	else:
		visible = false
		emit_signal("narration_finished")

signal narration_finished

class_name BaseNarration
extends CanvasLayer

## Base para telas de narração com efeito typewriter.[br]
## Subclasses precisam:[br]
## 1. Implementar [method _ready] chamando [method show_pages].[br]
## 2. Implementar [method _get_text_label] e [method _on_finished].[br]
## [method _get_continue_label] é opcional (retorna [code]null[/code] por padrão).
## Uso:
## [codeblock]
## func _ready() -> void:
##     show_pages(["página 1", "página 2"])
##
## @onready var _text_label = $NarrationBox/NarrationText
## func _get_text_label() -> RichTextLabel:
##     return _text_label
##
## func _on_finished() -> void:
##     get_tree().change_scene_to_file("res://cenarios/next.tscn")
## [/codeblock]

@export var typing_speed: float = 0.05 # segundos por caractere

var pages: Array[String] = []
var current_page: int = 0
var is_typing: bool = false
var current_tween: Tween = null


## Retorna o RichTextLabel onde o texto é digitado.
func _get_text_label() -> RichTextLabel:
	push_error("BaseNarration: override _get_text_label() na subclasse.")
	return null


## Retorna o Label de "continue" (ex: "Pressione E"). Null = sem label.
func _get_continue_label() -> Label:
	return null

## Chamada quando todas as páginas terminam. Troca de cena aqui.
func _on_finished() -> void:
	pass

## Define as páginas (já aplica BBCodeExtensions) e começa na página 0.
func show_pages(raw_texts: Array[String]) -> void:
	pages.assign(raw_texts.map(
		func(x: String) -> String: return BBCodeExtensions.parse(x)
	))
	current_page = 0
	visible = true
	_type_page(pages[current_page])


func _type_page(text: String) -> void:
	var text_label := _get_text_label()
	if text_label == null:
		return
	text_label.text = text
	text_label.visible_characters = 0
	is_typing = true
	_set_continue_visible(false)

	if current_tween:
		current_tween.kill()

	current_tween = create_tween()
	current_tween.tween_method(
		func(val: int): text_label.visible_characters = val,
		0,
		len(text),
		len(text) * typing_speed
	)
	current_tween.tween_callback(_on_type_finished)


func _on_type_finished() -> void:
	is_typing = false
	_set_continue_visible(true)


func _unhandled_input(event: InputEvent) -> void:
	if not visible:
		return
	if event.is_action_pressed("ui_accept"):
		if is_typing:
			_skip_typing()
		else:
			_next_page()


func _skip_typing() -> void:
	if current_tween:
		current_tween.kill()
	var text_label := _get_text_label()
	if text_label:
		text_label.visible_characters = -1
	is_typing = false
	_set_continue_visible(true)


func _next_page() -> void:
	current_page += 1
	if current_page < pages.size():
		_type_page(pages[current_page])
	else:
		visible = false
		_on_finished()


func _set_continue_visible(v: bool) -> void:
	var label := _get_continue_label()
	if label:
		label.visible = v


## Extrai o hack de spacing duplicado em narration/instructions.
func _apply_font_spacing(text_label: RichTextLabel, spacing: int = 1) -> void:
	if text_label == null:
		return
	var font: Font = text_label.get_theme_font("normal_font")
	if font is FontFile:
		font.set("cache/0/spacing_glyph", spacing)

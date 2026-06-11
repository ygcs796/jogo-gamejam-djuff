# narration_screen.gd
extends CanvasLayer

@onready var narration_text: RichTextLabel = $NarrationBox/MarginContainer/VBoxContainer/NarrationText
@onready var continue_label: Label = $NarrationBox/MarginContainer/VBoxContainer/ContinueLabel

@export var typing_speed: float = 0.05  # segundos por caractere

var pages: Array[String] = [
	
]
var current_page: int = 0
var is_typing: bool = false
var current_tween: Tween = null

func _ready():
	MusicManager.play(preload("res://audios/part2.ogg"))
	var font: FontFile = narration_text.get_theme_font("normal_font")
	print(font.get("cache/0/spacing_glyph"))
	font.set("cache/0/spacing_glyph", 1)
	print(font.get("cache/0/spacing_glyph"))
	
	continue_label.visible = false
	show_narration([
		"O mundo parecia comum, onde todas as noites e as manhãs se declaravam indescritivelmente perfeitas, mas… a realidade rachou ao meio, e tudo que era teto começou a virar chão.",
		"Claro, tudo o que foi criado foi transformado. Na busca por compreender a estrutura da própria realidade, um experimento acabou criando uma ruptura entre dois planos paralelos…",
		"De um lado, resta [color=yellow]Lumina[/color], que nem uma luz que ilumina, com todos os seus traços milimetricamente no lugar. Do avesso da arquitetura, nasce [color=purple]Umbra[/color], como uma fratura que deixa tudo fora do seu espaço.",
		"Poucos conseguem reconhecer a conexão entre esses dois mundos. Menos ainda conseguem atravessá-la. Essa habilidade se chama Shift."
	])

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
	
	# mata o tween anterior
	if current_tween:
		current_tween.kill()

	current_tween = create_tween()
	current_tween.tween_method(
		func(val: int): narration_text.visible_characters = val,
		0,
		len(text),
		len(text) * typing_speed
	)
	current_tween.tween_callback(func():
		is_typing = false
		continue_label.visible = true
	)

func _unhandled_input(event):
	if not visible:
		return
	if event.is_action_pressed("ui_accept"):
		if is_typing:
			if current_tween:
				# mata o tween quando eu aperto "barra de espaço"
				current_tween.kill()
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
		get_tree().change_scene_to_file("res://cenarios/instructions_screen.tscn")

signal narration_finished

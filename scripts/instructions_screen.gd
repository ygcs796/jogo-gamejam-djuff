extends CanvasLayer

@onready var narration_text: RichTextLabel = $InstructionBox/MarginContainer/VBoxContainer/NarrationText
@onready var continue_label: Label = $InstructionBox/MarginContainer/VBoxContainer/ContinueLabel
@onready var tileset: TileMapLayer = $TileMapLayer

func _ready() -> void:
	MusicManager.play(preload("res://audios/part3.ogg"))
	_configure_font()
	tileset.modulate.a = 0.5

func _configure_font() -> void:
	var font: Font = narration_text.get_theme_font("normal_font")

	if font is FontFile:
		font.set("cache/0/spacing_glyph", 1)
		print("Espaçamento da fonte:", font.get("cache/0/spacing_glyph"))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		get_tree().change_scene_to_file("res://cenarios/fase_1.tscn")

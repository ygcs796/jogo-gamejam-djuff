extends BaseNarration

func _ready() -> void:
	MusicManager.play(preload("res://audios/part2.ogg"))
	_apply_font_spacing(_get_text_label())
	show_pages([
		"O mundo parecia comum, onde todas as noites e as manhãs se declaravam indescritivelmente perfeitas, mas… a realidade rachou ao meio, e tudo que era teto começou a virar chão.",
		"Claro, tudo o que foi criado foi transformado. Na busca por compreender a estrutura da própria realidade, um experimento acabou criando uma ruptura entre dois planos paralelos…",
		"De um lado, resta [lumina], que nem uma luz que ilumina, com todos os seus traços milimetricamente no lugar. " +
		"Do avesso da arquitetura, nasce [umbra], como uma fratura que deixa tudo fora do seu espaço.",
		"Poucos conseguem reconhecer a conexão entre esses dois mundos. Menos ainda conseguem atravessá-la. Essa habilidade se chama Shift."
	])

@onready var _text_label = $NarrationBox/MarginContainer/VBoxContainer/ControlWrapper/NarrationText
func _get_text_label() -> RichTextLabel:
	return _text_label
	
@onready var _continue_label = $NarrationBox/MarginContainer/VBoxContainer/ContinueLabel
func _get_continue_label() -> Label:
	return _continue_label

func _on_finished() -> void:
	emit_signal("narration_finished")
	get_tree().change_scene_to_file("res://cenarios/instructions_screen.tscn")

signal narration_finished

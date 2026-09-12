extends BaseNarration

@onready var _text_label = $GratefulnessBox/MarginContainer/VBoxContainer/NarrationText
func _get_text_label() -> RichTextLabel:
	return _text_label

func _ready():
	MusicManager.play(preload("res://audios/part2.ogg"))
	show_pages([
		"Agradecemos imensamente por ter se imerso em nossa exploração entre os planos [lumina] e [umbra]. "+
		"Esta Vertical Slice foi criada como um vislumbre de um universo ainda maior, onde a Ruptura guarda segredos que ainda estão por ser revelados. "+
		"Embora esta jornada encerre aqui, muitos caminhos ainda permanecem ocultos, levando seus fluxos para outras direções.",
		
		"""A história entre [lumina] e [umbra] está apenas começando, e isso foi apenas o primeiro passo rumo ao que ainda resta do espaço dimensional.
		Character Design — [color=yellow]Emily Gomes[/color]
		Narrative Design — [color=purple]Micaellen Lima[/color]
		Visual Art — [color=yellow]Pedro Cruz[/color]
		Technical Game Design — [color=purple]Vitor Câmara[/color]
		Game Development — [color=yellow]Yuri Gabryel[/color]
		Game Development - [color=purple]Gustavo Santiago[/color]"""
	])

func _on_finished() -> void:
	get_tree().change_scene_to_file("res://cenarios/title_screen.tscn")

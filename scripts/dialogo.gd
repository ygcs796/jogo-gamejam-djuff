extends Control

@onready var dialog_text = $TextureRect/dialog_text

signal dialog_finished
var pages: Array = []
var current_page: int = 0

func _ready():
	visible = false

func show_dialog(texts: Array):
	pages = texts
	current_page = 0
	visible = true
	_show_page(pages[current_page])

func _show_page(line: String):
	dialog_text.text = line

func _unhandled_input(event):
	if not visible:
		return
	if event.is_action_pressed("ui_dialog"): # ação criada por mim
		current_page += 1
		if current_page < pages.size():
			_show_page(pages[current_page])
		else:
			visible = false
			Player.set_physics_process(true) # destravando o player
			emit_signal("dialog_finished")

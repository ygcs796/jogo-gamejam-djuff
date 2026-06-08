extends Node2D

@onready var cenario1 = $cenario1
@onready var cenario2 = $cenario2
@onready var label_vida = $vida
@onready var jogador = $Player

enum State { GROUND, CEILING }
var state: State = State.GROUND

func _ready():
	label_vida.text = "Vida: " + str(jogador.health)
	_apply_state()

func _unhandled_input(event):
	if event.is_action_pressed("swap"): # swap acontecendo no pulo
		_swap()

func _swap():
	if state == State.GROUND:
		state = State.CEILING
	else:
		state = State.GROUND
	_apply_state()

func _apply_state():
	# Alterna cenário do mapa
	cenario1.visible = (state == State.GROUND)
	cenario2.visible = (state == State.CEILING)


func _on_player_tomou_dano() -> void:
	label_vida.text = "Vida: " + str(jogador.health)

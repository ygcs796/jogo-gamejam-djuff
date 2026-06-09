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


func _on_porta_chegou_na_porta() -> void:
	if Player.qtde_chaves < 2:
		$dialogo.show_dialog([
			"Por trás desta porta de madeira revestida de tom marrom mogno, existe uma magnificência a ser explorada. Este lugar de aventura está perfeito para começar.",
			"Entretanto, toda jornada exige a chave que lhe dá origem."
		])
	else:
		$dialogo.show_dialog([
			"A porta que antes era como olhos fechados agora se abre, mas aqui, o que você enxerga não está à sua frente.",
			"Está acima. O mundo se inverteu, e a magnificência que existe do outro lado te olha de cabeça pra baixo.", 
			"Toda jornada exige a chave que lhe dá origem. Em Umbra, ela também é outra…"
		])
		

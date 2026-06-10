extends Node2D

@onready var cenario1 = $cenario1
@onready var cenario2 = $cenario2
@onready var label_vida = $vida
@onready var jogador = $Player

enum State { GROUND, CEILING }
var state: State = State.GROUND

func _ready():
	$simbolo_chave_completa.visible = false
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
		


func _on_chave_lumina_jogador_pegou_chave_lumina() -> void:
	Player.qtde_chaves += 1
	if Player.qtde_chaves == 2:
		$simbolo_chave_umbra.visible = false
		$simbolo_chave_completa.visible = true
	else:
		$simbolo_chave_lumina.visible = true
	$dialogo.show_dialog([
		"Este pequeno fragmento metálico é como uma artéria da própria dimensão, conduzindo o fluxo que percorre caminhos outrora adormecidos.",
		"Assim como o sangue encontra seu caminho até o coração, esta chave encontra a fechadura que lhe pertence. Em Lumina, uma nova passagem acaba de despertar…"
	])
	
func _on_chave_umbra_jogador_pegou_chave_umbra() -> void:
	Player.qtde_chaves += 1
	if Player.qtde_chaves == 2:
		$simbolo_chave_lumina.visible = false
		$simbolo_chave_completa.visible = true
	else:
		$simbolo_chave_umbra.visible = true
	$dialogo.show_dialog([
		"Agora, Lowen, envolta por sua natureza umbral, dá de cara com a Mácula Umbra da Agonia Mundana.",
		"Diz-se que, mesmo após a Ruptura, ela ainda preserva um dos caminhos que unem os dois mundos."
	])

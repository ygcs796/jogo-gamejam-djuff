extends Node2D

@onready var cenario1 = $cenario1
@onready var cenario2 = $cenario2
@onready var label_vida = $HUD/vida
@onready var jogador = $Player

#enum State { GROUND, CEILING }
#var state: State = State.GROUND
var porta_aberta: bool # variável que muda o valor quando o jogador pega 2 chaves
var pode_avancar: bool = false

func _ready():
	Player.qtde_chaves = 0
	Player.health = 3
	
	porta_aberta = false
	# configurando a câmera
	var tilemap: TileMapLayer = get_node("cenario1/chao_teto_lumina")
	var used = tilemap.get_used_rect()
	var tile_size = tilemap.tile_set.tile_size

	var cam: Camera2D = $Player/Camera2D
	cam.limit_left   = used.position.x * tile_size.x
	cam.limit_top    = used.position.y * tile_size.y
	cam.limit_right  = used.end.x * tile_size.x
	cam.limit_bottom = used.end.y * tile_size.y
	
	$HUD/simbolo_chave_completa.visible = false
	$HUD/simbolo_chave_lumina.visible = false
	$HUD/simbolo_chave_umbra.visible = false
	label_vida.text = "Vida: " + str(jogador.health)
	
	jogador.state_changed.connect(_on_state_changed)
	_on_state_changed(jogador.state)

#func _unhandled_input(event):
	#if event.is_action_pressed("swap"): # swap acontecendo no pulo
		#_swap()
#
#func _swap():
	#if state == State.GROUND:
		#state = State.CEILING
	#else:
		#state = State.GROUND
	#_apply_state()

func _on_state_changed(new_state):
	# Alterna cenário do mapa
	cenario1.visible = (new_state == 0)
	cenario2.visible = (new_state == 1)

func _on_player_tomou_dano() -> void:
	label_vida.text = "Vida: " + str(jogador.health)
	if jogador.health <= 0:
		#get_tree().quit()
		pass


func _on_porta_chegou_na_porta() -> void:
	if Player.qtde_chaves < 2:
		$HUD/dialogo.show_dialog([
			"Por trás desta porta de madeira revestida de tom marrom mogno, existe uma magnificência a ser explorada. Este lugar de aventura está perfeito para começar.",
			"Entretanto, toda jornada exige a chave que lhe dá origem."
		])
	elif Player.qtde_chaves == 2:
		porta_aberta = true
		pode_avancar = true
		$HUD/dialogo.show_dialog([
			"A porta que antes era como olhos fechados agora se abre, mas aqui, o que você enxerga não está à sua frente.",
			"Está acima. O mundo se inverteu, e a magnificência que existe do outro lado te olha de cabeça pra baixo.", 
			"Toda jornada exige a chave que lhe dá origem. Em Umbra, ela também é outra…"
		])
		


func _on_chave_lumina_jogador_pegou_chave_lumina() -> void:
	Player.qtde_chaves += 1
	if Player.qtde_chaves == 2:
		$HUD/simbolo_chave_umbra.visible = false
		$HUD/simbolo_chave_completa.visible = true
	else:
		$HUD/simbolo_chave_lumina.visible = true
	print("cheguei aqui")
	$HUD/dialogo.show_dialog([
		"Este pequeno fragmento metálico é como uma artéria da própria dimensão, conduzindo o fluxo que percorre caminhos outrora adormecidos.",
		"Assim como o sangue encontra seu caminho até o coração, esta chave encontra a fechadura que lhe pertence. Em Lumina, uma nova passagem acaba de despertar…"
	])
	
	
func _on_chave_umbra_jogador_pegou_chave_umbra() -> void:
	Player.qtde_chaves += 1
	if Player.qtde_chaves == 2:
		$HUD/simbolo_chave_lumina.visible = false
		$HUD/simbolo_chave_completa.visible = true
	else:
		$HUD/simbolo_chave_umbra.visible = true
	$HUD/dialogo.show_dialog([
		"Agora, Lowen, envolta por sua natureza umbral, dá de cara com a Mácula Umbra da Agonia Mundana.",
		"Diz-se que, mesmo após a Ruptura, ela ainda preserva um dos caminhos que unem os dois mundos."
	])


func _on_dialogo_dialog_finished() -> void: 
	# essa função só vai ser usada para passar de fase
	if pode_avancar:
		get_tree().change_scene_to_file("res://cenarios/final_narration_screen.tscn")

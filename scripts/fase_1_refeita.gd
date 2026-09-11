extends Node2D

@onready var player: CharacterBody2D = $Player
@onready var chave_umbra: Area2D = $chave_umbra
@onready var chave_lumina: Area2D = $chave_lumina
@onready var caixa_dialogo: Control = $HUD/dialogo
@onready var simbolo_chave_lumina: TextureRect = $HUD/simbolo_chave_lumina
@onready var simbolo_chave_umbra: TextureRect = $HUD/simbolo_chave_umbra
@onready var simbolo_chave_completa: TextureRect = $HUD/simbolo_chave_completa
@onready var label_vida: Label = $HUD/vida
@onready var label_cooldown_shift: Label = $HUD/cooldownShift

var porta_aberta: bool # variável que muda o valor quando o jogador pega 2 chaves
var pode_avancar: bool = false
var update_cooldown_label = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.health = 3
	player.qtde_chaves = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if update_cooldown_label:
		if is_node_ready():
			label_cooldown_shift.text = "%.1f" % player.get_node("cooldown_shift").time_left

func _on_porta_chegou_na_porta() -> void:
	if player.qtde_chaves < 2:
		caixa_dialogo.show_dialog([
			"Por trás desta porta de madeira revestida de tom marrom mogno, existe uma magnificência a ser explorada. Este lugar de aventura está perfeito para começar.",
			"Entretanto, toda jornada exige a chave que lhe dá origem."
		])
	elif player.qtde_chaves == 2:
		porta_aberta = true
		pode_avancar = true
		caixa_dialogo.show_dialog([
			"A porta que antes era como olhos fechados agora se abre, mas aqui, o que você enxerga não está à sua frente.",
			"Está acima. O mundo se inverteu, e a magnificência que existe do outro lado te olha de cabeça pra baixo.", 
			"Toda jornada exige a chave que lhe dá origem. Em Umbra, ela também é outra…"
		])

func _on_chave_lumina_jogador_pegou_chave_lumina() -> void:
	pode_avancar = false
	player.qtde_chaves += 1
	if player.qtde_chaves == 2:
		simbolo_chave_umbra.visible = false
		simbolo_chave_completa.visible = true
	else:
		simbolo_chave_lumina.visible = true
	caixa_dialogo.show_dialog([
		"Este pequeno fragmento metálico é como uma artéria da própria dimensão, conduzindo o fluxo que percorre caminhos outrora adormecidos.",
		"Assim como o sangue encontra seu caminho até o coração, esta chave encontra a fechadura que lhe pertence. Em Lumina, uma nova passagem acaba de despertar…"
	])
	
func _on_chave_umbra_jogador_pegou_chave_umbra() -> void:
	pode_avancar = false 
	player.qtde_chaves += 1
	if player.qtde_chaves == 2:
		simbolo_chave_lumina.visible = false
		simbolo_chave_completa.visible = true
	else:
		simbolo_chave_umbra.visible = true
	caixa_dialogo.show_dialog([
		"Agora, Lowen, envolta por sua natureza umbral, dá de cara com a Mácula Umbra da Agonia Mundana.",
		"Diz-se que, mesmo após a Ruptura, ela ainda preserva um dos caminhos que unem os dois mundos."
	])

func _on_player_tomou_dano() -> void:
	label_vida.text = "Vida: " + str(player.health)
	if player.health <= 0:
		# Antes de abrir a tela de morte
		Global.cena_anterior = get_tree().current_scene.scene_file_path
		get_tree().change_scene_to_file("res://cenarios/game_over.tscn")

func _on_player_state_changed(new_state: Variant) -> void:
	#cenario1.visible = (new_state == 0) #qnd adicionar os 2 tilemaps botar aqui
	#cenario2.visible = (new_state == 1)
	update_cooldown_label = true

func _on_dialogo_dialog_finished() -> void: 
	# essa função só vai ser usada para passar de fase
	if pode_avancar:
		get_tree().change_scene_to_file("res://cenarios/fase_2_REFEITA.tscn")

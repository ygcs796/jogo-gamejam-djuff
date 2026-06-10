extends Area2D

signal jogador_pegou_chave_umbra

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		jogador_pegou_chave_umbra.emit()
		queue_free()

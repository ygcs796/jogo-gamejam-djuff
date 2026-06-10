extends Area2D

signal jogador_pegou_chave_lumina

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		jogador_pegou_chave_lumina.emit()
		queue_free()

extends Area2D

signal chegou_na_porta

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		chegou_na_porta.emit()

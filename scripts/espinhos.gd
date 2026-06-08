# spikes.gd
extends Area2D

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node2D):
	if body.is_in_group("player"):
		var normal = (body.global_position - global_position).normalized()
		body.take_damage(normal)

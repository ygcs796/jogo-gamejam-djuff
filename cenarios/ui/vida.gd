extends HBoxContainer

@export var total_vida = 3
@export var vida: HBoxContainer

enum State { GROUND, CEILING }

var corações : Dictionary = {
	"amarelo": load("res://assets/ui/coração amarelo.png"),
	"roxo": load("res://assets/ui/coração roxo.png")
}

func _ready() -> void:
	for i in range(total_vida):
		var png = TextureRect.new()
		png.texture = corações['amarelo']
		vida.add_child(png)
	
	return

func swap_heart_color(state : State) -> void:
	var nodes = vida.get_children() as Array[TextureRect]
	
	for node in nodes:
		if state == State.CEILING:
			node.texture = corações['roxo']
		else:
			node.texture = corações['amarelo']
	
	return

func delete_heart() -> void:
	if total_vida > 0: 
		vida.get_children()[-1].queue_free()
		total_vida -= 1
	return

	

extends PanelContainer

@onready var home: Button = $conteudo/HBoxContainer/Home
@onready var sound: Button = $conteudo/HBoxContainer/Sound
@onready var retry: Button = $conteudo/HBoxContainer/Retry
var sons = {
	"mutado": load("res://assets/ui/botão som mutado.png"),
	"unmute": load("res://assets/ui/botão som.png")
}


func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false
	if MusicManager.player.volume_linear != 0:
		sound.icon = sons['unmute']
	else:
		sound.icon = sons['mutado']

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("pausar"):
		visible = true
		get_tree().paused = true

func _on_home_pressed() -> void:
	Global.go_home()


func _on_sound_pressed() -> void:
	if MusicManager.player.volume_linear == 0:
		sound.icon = sons['unmute']
		MusicManager.player.volume_linear = 1
	else:
		sound.icon = sons['mutado']
		MusicManager.player.volume_linear = 0


func _on_continuar_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_retry_pressed() -> void:
	get_tree().paused = false
	get_tree().reload_current_scene()
	

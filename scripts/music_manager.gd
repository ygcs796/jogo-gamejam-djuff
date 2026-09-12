# music_manager.gd
extends Node

var player: AudioStreamPlayer
var next_stream: AudioStream = null  # música enfileirada

func _ready():
	var ap = AudioStreamPlayer.new()
	add_child(ap)
	player = ap
	player.finished.connect(_on_finished)  # loop manual

func play(stream: AudioStream):
	if player.stream == stream and player.playing:
		return  # já tocando essa música, não reinicia
	if not player.playing:
		# Nenhuma música tocando, inicia direto
		next_stream = null
		player.stream = stream
		player.play()
	else:
		# Enfileira para tocar ao fim da repetição atual
		print("música 2")
		next_stream = stream

func stop():
	next_stream = null
	player.stop()
	
func _on_finished():
	if next_stream != null:
		print("Trocando de música")
		# Troca para a música enfileirada
		player.stream = next_stream
		next_stream = null
		player.play()
	else:
		# Sem próxima música, repete a atual
		player.play()

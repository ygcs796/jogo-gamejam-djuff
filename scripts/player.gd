# player.gd
extends CharacterBody2D

const SPEED = 180.0
const JUMP_VELOCITY = 400.0

@onready var skin_ground = $SkinGround
@onready var skin_ceiling = $SkinCeiling

enum State { GROUND, CEILING }
var state: State = State.GROUND

var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	_apply_state()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"): # swap acontecendo no pulo
		_swap()

func _swap():
	if state == State.GROUND:
		state = State.CEILING
	else:
		state = State.GROUND
	_apply_state()

func _apply_state():
	# Alterna skin
	skin_ground.visible = (state == State.GROUND)
	skin_ceiling.visible = (state == State.CEILING)

func _physics_process(delta):
	var on_surface: bool
	var jump_dir: float

	if state == State.GROUND:
		velocity.y += gravity * delta
		on_surface = is_on_floor()
		jump_dir = -1.0  # pula pra cima
	else:
		velocity.y -= gravity * delta  # gravidade invertida
		on_surface = is_on_ceiling()
		jump_dir = 1.0   # pula pra baixo

	if Input.is_action_just_pressed("ui_accept") and on_surface:
		velocity.y = JUMP_VELOCITY * jump_dir

	var dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * SPEED

	move_and_slide()

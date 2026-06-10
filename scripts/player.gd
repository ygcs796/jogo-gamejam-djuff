# player.gd
extends CharacterBody2D

# "importações"
@onready var skin_ground = $SkinGround
@onready var skin_ceiling = $SkinCeiling
@onready var animacao_lumina = $animacao_lumina
@onready var animacao_umbra = $animacao_umbra

# costantes
const SPEED = 180.0
const JUMP_VELOCITY = 300.0
const KNOCKBACK_FORCE = 300.0
const MAX_HEALTH = 3

# variáveis que vou usar no meu script
enum State { GROUND, CEILING }
var state: State = State.GROUND
@export var health: int = MAX_HEALTH
var knockback: Vector2 = Vector2.ZERO
var is_invincible: bool = false
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
signal tomou_dano
var qtde_chaves: int = 0

func _ready():
	animacao_umbra.flip_v = true
	_apply_state()

func _unhandled_input(event):
	if event.is_action_pressed("swap"): # swap acontecendo no pulo
		_swap()

func _swap():
	if state == State.GROUND:
		state = State.CEILING
	else:
		state = State.GROUND
	_apply_state()

func _apply_state():
	# Alterna skin
	animacao_lumina.visible = (state == State.GROUND)
	
	animacao_umbra.visible = (state == State.CEILING)

func _physics_process(delta):
	var on_surface: bool
	var jump_dir: float

	# Aplica knockback se houver
	if knockback != Vector2.ZERO:
		velocity = knockback
		knockback = knockback.move_toward(Vector2.ZERO, 800 * delta)

	if state == State.GROUND:
		velocity.y += gravity * delta
		on_surface = is_on_floor()
		jump_dir = -1.0  # pula pra cima
	else:
		velocity.y -= gravity * delta  # gravidade invertida
		on_surface = is_on_ceiling()
		jump_dir = 1.0   # pula pra baixo

	if Input.is_action_just_pressed("ui_accept") and on_surface:
		if animacao_lumina.visible:
			animacao_lumina.play("pulando")
		elif animacao_umbra.visible:
			animacao_umbra.play("pulando")
		velocity.y = JUMP_VELOCITY * jump_dir

	var dir = Input.get_axis("ui_left", "ui_right")
	velocity.x = dir * SPEED
	# pela direção, decidindo se a animação vai ser invertida ou não
	if dir > 0: 
		if animacao_lumina.visible:
			animacao_lumina.flip_h = false
		elif animacao_umbra.visible:
			animacao_umbra.flip_h = false
	elif dir < 0:
		if animacao_lumina.visible:
			animacao_lumina.flip_h = true
		elif animacao_umbra.visible:
			animacao_umbra.flip_h = true

	move_and_slide()
	
func take_damage(normal: Vector2):
	tomou_dano.emit()
	if is_invincible:
		return
	health -= 1
	knockback = normal * KNOCKBACK_FORCE
	is_invincible = true
	# Pisca o personagem durante a invencibilidade
	var tween = create_tween().set_loops(4)
	tween.tween_property(self, "modulate:a", 0.2, 0.1)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	await get_tree().create_timer(1.0).timeout
	is_invincible = false
	modulate.a = 1.0

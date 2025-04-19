extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var speed := 200
var run_speed := 350
var jump_velocity := -400
var gravity := 1000
var max_jumps := 2
var jumps_left := 2

func _physics_process(delta: float) -> void:
	var velocity = self.velocity
	var is_moving := false

	if not is_on_floor():
		velocity.y += gravity * delta
		if velocity.y > 0:
			animated_sprite_2d.play("Fall")
		else:
			animated_sprite_2d.play("Jump")
	else:
		jumps_left = max_jumps

	if Input.is_action_just_pressed("Saltar") and jumps_left > 0:
		velocity.y = jump_velocity
		animated_sprite_2d.play("Jump")
		jumps_left -= 1

	var direction := 0
	if Input.is_action_pressed("Derecha"):
		direction += 1
		animated_sprite_2d.flip_h = false
	if Input.is_action_pressed("Izquierda"):
		direction -= 1
		animated_sprite_2d.flip_h = true

	var current_speed = speed
	if direction != 0:
		is_moving = true
		if Input.is_action_pressed("Correr") and is_on_floor():
			current_speed = run_speed
			animated_sprite_2d.play("Run")
		elif is_on_floor():
			animated_sprite_2d.play("Walk")
	elif is_on_floor():
		animated_sprite_2d.play("Idle")
	velocity.x = direction * current_speed

	self.velocity = velocity
	move_and_slide()

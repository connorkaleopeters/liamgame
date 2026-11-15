extends CharacterBody2D

@onready var liam = $PickupArea/LiamSprite
@onready var liamsax = $heldsax
@onready var muzzle = $heldsax/wherestuffcomesout 

const NOTE_SCENE = preload("res://music_note.tscn")

const GRAVITY = 980.0
const JUMP_VELOCITY = -450.0
const SPEED = 400.0
const COOLDOWN = 0.4
var facing_direction = 1
var can_shoot = true
func _physics_process(delta: float) -> void:
	add_to_group("player")
	if not is_on_floor():
		velocity.y += GRAVITY * delta
	if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		$JustinHelp.visible = false
	var crouchingliam = Input.is_action_pressed("ui_down") and is_on_floor()
	if Input.is_action_pressed("ui_up") and is_on_floor() and not crouchingliam:
		velocity.y = JUMP_VELOCITY
	var input_direction = Input.get_axis("ui_left", "ui_right")
	if Input.is_action_pressed("ui_select") and liamsax.visible and can_shoot:
		shoot_sax()
	if crouchingliam:
		velocity.x = 0
	else:
		velocity.x = input_direction * SPEED
	move_and_slide()
	if input_direction > 0:
		liam.flip_h = false
		liamsax.flip_h = true
	elif input_direction < 0:
		liam.flip_h = true
		liamsax.flip_h = false
	if crouchingliam:
		liam.play("crouching")
	elif input_direction != 0:
		liam.play("walk")
	else:
		liam.play("idle")
func die() -> void:
	get_tree().call_deferred("reload_current_scene")
func shoot_sax() -> void:
	can_shoot = false
	var note = NOTE_SCENE.instantiate()
	note.global_position = muzzle.global_position
	get_tree().current_scene.add_child(note)
	await get_tree().create_timer(COOLDOWN).timeout
	can_shoot = true
func _on_pickup_area_area_entered(area):
	if area.is_in_group("sax"):
		area.queue_free()
		$heldsax.visible = true
func bounce(force: float) -> void:
	velocity.y = force

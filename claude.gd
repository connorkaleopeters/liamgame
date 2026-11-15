extends Area2D
const NOTE_SCENE = preload("res://claudeshot.tscn")
var radius = 200
var speed = 4
var angle = 0
var start_position = Vector2.ZERO
var health = 20
var is_on_screen = false
@onready var claude =$AnimatedSprite2D
func _ready() -> void:
	claude.play("idle")
	claude.flip_h = true
	start_position = global_position
func _physics_process(delta: float) -> void:
	angle += speed * delta
	if can_shoot and is_on_screen:
		shoot_sax()
	var offset = Vector2(cos(angle), sin(angle)) * radius
	global_position = start_position + offset
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("die"):
			body.die()
func take_damage(amount: int) -> void:
	health -= amount
	modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE
	if health <= 0:
		queue_free()
@onready var muzzle = $Marker2D
const COOLDOWN = 0.4
var can_shoot = true
func shoot_sax() -> void:
	can_shoot = false
	var note = NOTE_SCENE.instantiate()
	note.global_position = muzzle.global_position
	get_tree().current_scene.add_child(note)
	await get_tree().create_timer(COOLDOWN).timeout
	can_shoot = true


func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	is_on_screen = true


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	is_on_screen = false

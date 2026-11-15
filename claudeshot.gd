extends Area2D

const SPEED = 800.0
var direction = -1
@onready var claude =$AnimatedSprite2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	claude.play("default")

func _physics_process(delta: float) -> void:
	position.x += SPEED * direction * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if body.has_method("die"):
			body.die()
		queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

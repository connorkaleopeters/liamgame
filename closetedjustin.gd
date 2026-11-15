extends Area2D
var start_position = Vector2.ZERO
var health = 5
func _ready() -> void:
	start_position = global_position

func take_damage(amount: int) -> void:
	health -= amount
	modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	modulate = Color.WHITE
	if health <= 0:
		queue_free()

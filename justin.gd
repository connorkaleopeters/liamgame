extends AnimatableBody2D
@onready var closetedjustin: Area2D = $"../closetedjustin"
@onready var justin =$JustinSprite
func _physics_process(delta: float) -> void:
	justin.flip_h = true 
	if is_instance_valid(closetedjustin):
		justin.play("idle")
	else:
		justin.play("happy")

extends RigidBody2D
@onready var liam = $PickupArea/LiamSprite
@onready var liamsax = $heldsax
func _physics_process(delta):
	
	var input_direction = Input.get_vector("ui_left","ui_right", "ui_up", "ui_down")
	velocity = input_direction * 400
	move_and_slide()
	if Input.is_action_pressed("ui_right"):
		liam.flip_h = false
		liamsax.flip_h = true
		liam.play("walk")
	elif Input.is_action_pressed("ui_left"):
		liam.flip_h = true
		liam.play("walk")
		liamsax.flip_h = false
	else:
		liam.play("idle")
func _on_pickup_area_area_entered(area):
	if area.is_in_group("sax"):
		area.queue_free()
		$heldsax.visible = true

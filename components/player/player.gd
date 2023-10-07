class_name Player extends Area2D

@export var speed = 200

var screen_size

var inputs = {yUp= -1, yDown= 1, xLeft= -1, xRight= 1}

func start(pos: Vector2):
	screen_size = get_viewport_rect().size
	position = pos
	show()

func handle_input(delta):
	if $HealthSystem.is_dead():
		return

	var velocity = Vector2.ZERO
	if Input.is_action_pressed('y_down'):
		velocity.y += inputs.yDown
	if Input.is_action_pressed('y_up'):
		velocity.y += inputs.yUp
	if Input.is_action_pressed('x_left'):
		velocity.x += inputs.xLeft
	if Input.is_action_pressed('x_right'):
		velocity.x += inputs.xRight

	if Input.is_action_just_pressed("fire"):
		$WeaponsSystem.fire()

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

func _process(delta: float):
	handle_input(delta)

func _on_died():
	$AnimatedSprite2D.stop()
	hide()

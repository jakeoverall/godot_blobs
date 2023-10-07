extends CharacterBody2D

class_name Mob

var _target : Area2D
signal died()

@export_subgroup("Speed")
@export var minSpeed : float = 10
@export var maxSpeed: float = 100

@onready var speed = randf_range(minSpeed, maxSpeed)

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite2D.self_modulate = Color.from_ok_hsl(randf_range(0,360), 1, randf_range(0.3, 0.8), 1) 
	$AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _target != null:
		position = position.move_toward(_target.position, speed * delta)

func set_target(target:Area2D):
	_target = target


func _on_died():
	hide()
	died.emit()
	queue_free()
	

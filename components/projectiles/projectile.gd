extends Node2D

class_name Projectile

@export var speed : float = 800

func _physics_process(delta):
  position += transform.x * speed * delta

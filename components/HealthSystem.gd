extends Node

class_name HealthSystem

signal current_health_changed
signal died
signal max_health_changed


@export_category("Health Setting")
@export var max_health: float = 1
@export var current_health: float

func is_dead():
	return current_health <= 0
	
func _ready(): 
	current_health = max_health

func _set_health(value:float):
	current_health = value
	clamp_health()
	
func _adjust_health(value:float):
	current_health += value
	clamp_health()

func clamp_health():
	current_health = clampf(current_health, 0, max_health)
	print('current health ', current_health)
	if current_health <= 0:
		died.emit()	
		print('DEAD ', current_health)
	else:
		current_health_changed.emit()

func set_max_health(value:float):
	max_health = value
	max_health_changed.emit()

func adjust_max_health(value:float):
	max_health += value
	max_health_changed.emit()

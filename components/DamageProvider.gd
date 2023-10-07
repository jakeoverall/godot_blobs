extends Node

class_name DamageProvider

@export var type : String = 'enemy'
@export var max_damage : float = 1
@export var min_damage : float = 0

func roll_damage() -> float:
	return randf_range(min_damage, max_damage)


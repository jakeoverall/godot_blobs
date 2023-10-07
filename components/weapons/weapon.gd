extends Node2D

class_name Weapon

@export var base_damage: float = 1
@export var projectile: PackedScene


func trigger(_mods: Array[WeaponMod]):
	var p = projectile.instantiate()
	add_child(p)
	p.transform = $Marker2D.transform

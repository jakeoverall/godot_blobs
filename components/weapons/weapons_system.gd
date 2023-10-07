extends Node

class_name WeaponsSystem

@export_category("Weapons System Config")
@export var cooldown_time: float = 1
@export var weapon_slots: float = 1

@export_category("Current Loadout (Equipment)")
@export var weapons: Array[Weapon] = []
@export var system_mods: Array[SystemsMod] = []
@export var weapon_mods: Array[WeaponMod] = []

var is_on_cooldown: bool = false


func _ready():
	$cdTimer.connect("timeout", _on_cooldown)


func _on_weapon_pickup(weapon: Weapon):
	if weapons.find(weapon) == null:
		weapons.append(weapon)


func _on_weapon_mod_pickup(weaponMod: WeaponMod):
	weapon_mods.append(weaponMod)


func fire():
	if is_on_cooldown:
		return
	print('Fire')
	weapons.all(fire_weapon)
	is_on_cooldown = true
	$cdTimer.start(cooldown_time)


func fire_weapon(weapon: Weapon):
	weapon.trigger(weapon_mods)


func _on_cooldown():
	is_on_cooldown = false

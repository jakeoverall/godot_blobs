extends Node

class_name DamageReciever

@export var collider: Area2D
@export var health_system: HealthSystem
@export var is_damageable:bool = true
@export var invulnerable_on_hit_time:float = .35
@export var hurt_by : Array[String] = []

func _ready():
	$InvulnerableTimer.connect('timeout', _on_invulnerable_timeout)

func recieve_damage(value: float):
	if is_damageable:
		health_system._adjust_health(-absf(value))
		is_damageable = false
		$InvulnerableTimer.start(invulnerable_on_hit_time)

func _on_invulnerable_timeout():
	is_damageable = true
	$InvulnerableTimer.stop()

func accepts_damage_from(provider: DamageProvider):
	return hurt_by.find(provider.type)

func _on_body_entered(body: Node2D):
	var damageProvider = body.get_node('DamageProvider')
	if damageProvider != null:
		print_debug('Colliding with ', damageProvider.type)
		recieve_damage(damageProvider.roll_damage())

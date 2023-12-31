extends Node

@export var score = 0
@export var mob_scene: PackedScene
@export var mobs: Array[Mob] = []
# Called when the node enters the scene tree for the first time.
func _ready():
	new_game()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()

func new_game():
	print('start game')
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_score_timer_timeout():
	score += 1

func _on_start_timer_timeout():
	print('start timeout')
	$MobTimer.connect("timeout", _on_mob_timer_timeout)
	$ScoreTimer.connect("timeout", _on_score_timer_timeout)
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	if mobs.size() > 3:
		return
	print('spawn mob')
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()
	# Set the mob's direction perpendicular to the path direction.
	# var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position
	# Spawn the mob by adding it to the Main scene.
	mob.set_target($Player)
	mob.connect('died', func(): mobs.erase(mob))
	add_child(mob)
	mobs.append(mob)

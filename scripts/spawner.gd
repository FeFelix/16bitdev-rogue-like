extends Node2D

@export var player: CharacterBody2D
@export var enemy: PackedScene
@export var enemy_types: Array[Enemy]

var distance: float = 400.0
var can_spawn: bool = true

var minute: int:
	set(value):
		minute = value
		%Minute.text = str(value)

var second: int:
	set(value):
		second = value
		if second >= 10:
			second -= 10
			minute +=1
		%Second.text = str(second).lpad(2, "0")

func _physics_process(_delta: float) -> void:
	if get_tree().get_node_count_in_group("Enemy") < 700:
		can_spawn = true
	else:
		can_spawn = false

func spawn(pos: Vector2, elite:bool = false)-> void:
	if not can_spawn and not elite:
		return
	var enemy_stance: CharacterBody2D = enemy.instantiate()
	
	enemy_stance.type = enemy_types[min(minute, enemy_types.size()-1)]
	enemy_stance.position = pos
	enemy_stance.player_reference = player
	enemy_stance.elite = elite
	
	get_tree().current_scene.add_child(enemy_stance)

func get_random_position()-> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(number: int = 1)-> void:
	for i in range(number):
		spawn(get_random_position())

func _on_timer_timeout() -> void:
	second += 1
	amount(second % 10)

func _on_pattern_timeout() -> void:
	for i in range(75):
		spawn(get_random_position())

func _on_elite_timeout() -> void:
	spawn(get_random_position(), true)

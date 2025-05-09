extends CharacterBody2D

@export var player_reference: CharacterBody2D

var direction: Vector2
var speed: float = 75.0
var damage: float

var elite: bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://shaders/rainbow.tres")
			scale = Vector2(1.5, 1.5)

var type: Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture
		damage = value.damage

func _physics_process(delta: float) -> void:
	var separation: float = (player_reference.position - position).length()
	if separation >= 500 and not elite:
		queue_free()
	
	velocity = (player_reference.position - position).normalized() * speed
	move_and_collide(velocity * delta)

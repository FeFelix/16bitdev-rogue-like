extends CharacterBody2D

var speed: float = 150.0

var health: float = 100.0:
	set(value):
		health = value
		%Health.value = value

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down").normalized() * speed
	move_and_collide(velocity * delta)

func take_damage(amount)-> void:
	health -= amount
	print(amount)

func _on_set_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)

func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)

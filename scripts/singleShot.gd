extends Weapon
class_name SingleShot

func shoot(source, target, scene_tree) -> void:
	if target == null:
		return
	
	var projectile: Projectile = projectile_node.instantiate()
	
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.direction = (target.position - source.position). normalized()
	
	scene_tree.current_scene.add_child(projectile)

func activate(source, target, scene_tree) -> void:
	shoot(source, target, scene_tree)

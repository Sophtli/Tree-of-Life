extends Timer

@export var target_location: Node
@export var enemy_scene: PackedScene

var i: int = 0

func _on_timeout():
	var amount: int = i / 10 + 3
	
	for i in range(amount):
		var enemy: Enemy = enemy_scene.instantiate()
		enemy.target_location = target_location.position
		enemy.position.x = randi_range(100, 1120)
		enemy.position.y = randi_range(800, 1000)
		add_child(enemy)
	
	i += 1

extends Node2D

signal game_over(time: String)
signal tick(time: String)
@onready var health_bar: ProgressBar = %HealthBar
@onready var tree_bottom = %"Tree-Bottom"
@onready var tree_top = %"Tree-Top"

signal oxygen_produced(value: float)
var health: float = 100
var time: float

func _process(delta):
	health_bar.value = health
	time += delta

	var minutes := time / 60
	var seconds := fmod(time, 60)
	var time_string := "%02d:%02d" % [minutes, seconds]
	emit_signal("tick", time_string)
	
func _physics_process(delta):
	emit_signal("oxygen_produced", delta * 4 * (health / 100))

func _on_area_entered(area):
	if area.get_name() != "Sword":
		var tween := create_tween().set_ease(Tween.EASE_IN_OUT)
	
		tween.tween_property(tree_bottom, "modulate:a", 0.1, 0.3)
		tween.parallel().tween_property(tree_top, "modulate:a", 0.1, 0.3)
		
		tween.tween_property(tree_bottom, "modulate:a", 1, 0.3)
		tween.parallel().tween_property(tree_top, "modulate:a", 1, 0.3)
		
		health -= 10
	if health <= 0:
		emit_signal("game_over")

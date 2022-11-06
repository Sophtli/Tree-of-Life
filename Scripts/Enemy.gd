extends CharacterBody2D
class_name Enemy

@onready var health_bar = %HealthBar
@onready var navigation_agent : NavigationAgent2D = %NavigationAgent
const SPEED = 100.0
var target_location: Vector2
var _velocity: Vector2
var health: int = 3

func _ready():
	navigation_agent.target_location = target_location

func _process(delta):
	health_bar.value = health*100 / 3.0

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		return
	
	var target = navigation_agent.get_next_location()
	var direction = global_position.direction_to(target)
	
	var desired_velocity = direction * SPEED
	var steering = (desired_velocity - _velocity) * delta * 4.0
	
	_velocity += steering
	
	navigation_agent.set_velocity(_velocity)

func _on_navigation_agent_velocity_computed(safe_velocity):
	velocity = safe_velocity
	move_and_slide()

func _on_hit(area: Area2D):
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT)
	
	if area.get_name() == "Sword":
		tween.tween_property(%Sprite, "modulate:a", 0.1, 0.3)
		tween.tween_property(%Sprite, "modulate:a", 1, 0.3)
				
		health -= 1
		if health == 0:
			tween.tween_property(%Sprite, "modulate:a", 0, 0.3)
			queue_free()
	
	if area.get_name() == "Tree":
		tween.tween_property(%Sprite, "modulate:a", 0, 0.3)
		queue_free()

extends CharacterBody2D

signal oxygen_update(value: float)
@onready var sprite : Sprite2D = %Sprite
@onready var animation_player : AnimationPlayer = %AnimationPlayer

const SPEED = 300.0
var oxygen : float = 100.0

func _process(delta):
	var tween := create_tween().set_ease(Tween.EASE_IN_OUT)
	
	if oxygen <= 5:
		tween.tween_property(%Sprite, "modulate:a", 0.3, 0.3)
	else:
		tween.tween_property(%Sprite, "modulate:a", 1, 0.3)

func _physics_process(delta):
	oxygen += delta * 0.1
	
	var x = Input.get_axis("left", "right")
	var y = Input.get_axis("up", "down")
		
	# weird workaround because scale.x = -1 is buggy
	if x > 0:
		scale.y = 1
		rotation = deg_to_rad(0)
	elif x < 0:
		scale.y = -1
		rotation = deg_to_rad(180)
	if x != 0 or y != 0:
		if !animation_player.is_playing():
			animation_player.play("walk")
		
	if Input.is_action_pressed("attack"):
		if oxygen >= 5:
			if 	!animation_player.is_playing():
				animation_player.play("attack")
				_on_attack()
			else: 
				if animation_player.current_animation == "walk":
					animation_player.play("attack_walk")
					_on_attack()

	velocity = Vector2(x,y).normalized() * SPEED
	move_and_slide()
	
	position.x = clamp(position.x, 24, get_viewport_rect().size.x - 24)
	position.y = clamp(position.y, 32, get_viewport_rect().size.y - 32)
	
	emit_signal("oxygen_update", oxygen)

func _on_attack():
	oxygen = clamp(oxygen - 5, 0, 100)

func _on_tree_oxygen_produced(value):
	oxygen = clamp(oxygen + value, 0, 100)

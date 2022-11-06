extends Control

@export var oxygen : float
@onready var pause_menu = %PauseMenu
@onready var game_over = %GameOver
@onready var time_label = %TimeLabel

var time: String

func pause():
	get_tree().paused = true
	pause_menu.show()

func _on_player_oxygen_update(value: float):
	oxygen = value
	
func _on_game_over():
	game_over.show()
	get_tree().paused = true
	
func _on_tick(time: String):
	game_over.time = time
	time_label.text = time

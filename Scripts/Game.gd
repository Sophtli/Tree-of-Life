extends Control

@onready var ui = %UI

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		ui.pause()

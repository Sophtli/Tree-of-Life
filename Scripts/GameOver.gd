extends ColorRect

@onready var time_label = %TimeLabel

var time: String

func _process(_delta):
	time_label.text = time

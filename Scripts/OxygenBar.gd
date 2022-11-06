extends ProgressBar

@onready var ui = $"../../.."

func _process(_delta):
	value = ui.oxygen

extends Control

@onready var day_label: Label = %DayLabel
@onready var hour_label: Label = %HourLabel

func _process(_delta: float) -> void:
	day_label.text = "Day\n" + str(TimeSystem.day_count)
	hour_label.text = TimeSystem.get_time_string()

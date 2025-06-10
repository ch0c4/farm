extends Control

@onready var day_label: Label = %DayLabel
@onready var hour_label: Label = %HourLabel

func _process(_delta: float) -> void:
	day_label.text = "Day\n" + str(TimeSystem.day_count)
	hour_label.text = TimeSystem.get_time_string()


func _on_stop_button_pressed() -> void:
	TimeSystem.is_stopped = true


func _on_play_button_pressed() -> void:
	TimeSystem.is_stopped = false


func _on_next_day_button_pressed() -> void:
	TimeSystem.day_count += 1

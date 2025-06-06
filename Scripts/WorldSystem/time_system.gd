extends Node

signal day_started
signal night_started
signal new_day(day_count: int)

const REAL_MINUTES_PER_DAY := 1
const START_HOUR := 8
const HOURS_IN_DAY := 24
const SECONDS_PER_MINUTE := 60.0

var day_count := 1
var current_hour := START_HOUR
var current_minute := 0.0
var time_speed := HOURS_IN_DAY / (REAL_MINUTES_PER_DAY * SECONDS_PER_MINUTE)

var is_day := true

func _process(delta: float) -> void:
	current_minute += time_speed * delta * 10
	if current_minute >= 60.0:
		current_minute -= 60.0
		current_hour += 1
		if current_hour >= HOURS_IN_DAY:
			current_hour = 0
			day_count += 1
			new_day.emit(day_count)
		
		if current_hour == 8 and not is_day:
			is_day = true
			day_started.emit()
		elif current_hour == 20 and is_day:
			is_day = false
			night_started.emit()


func get_time_string() -> String:
	var hour_str = str(current_hour).pad_zeros(2)
	var min_str = str(int(current_minute)).pad_zeros(2)
	return "%s:%s" % [hour_str, min_str]

extends ColorRect


func _process(_delta: float) -> void:
	var hour = TimeSystem.current_hour
	var minute = TimeSystem.current_minute
	var time = hour + minute / 60
	
	var target_alpha := 0.0
	
	if time >= 18.0 and time < 20.0:
		target_alpha = (time - 18.0) / 2.0
	elif time >= 20.0 or time < 4.0:
		target_alpha = 1.0
	elif time >= 4.0 and time < 6.0:
		target_alpha = 1.0 - ((time - 4.0) / 2.0)
	
	color.a = lerp(color.a, target_alpha * 0.5, 0.05)
	

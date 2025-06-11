extends Area2D

signal target_entered
signal target_exited

var on_fish := false

func _physics_process(_delta: float) -> void:
	global_position = get_global_mouse_position()
	_check_on_fish()


func _check_on_fish() -> void:
	var bodies := get_overlapping_bodies()
	
	if bodies.is_empty() and on_fish:
		on_fish = false
		target_exited.emit()
	elif not bodies.is_empty() and not on_fish:
		on_fish = true
		target_entered.emit()

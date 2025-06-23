extends State


func enter() -> void:
	EventSystem.end_construction_mode.connect(_on_end_construction_mode)
	EventSystem.start_construction_mode.emit()


func exit() -> void:
	EventSystem.end_construction_mode.disconnect(_on_end_construction_mode)


func _on_end_construction_mode() -> void:
	transitionned.emit(self, "Idle")

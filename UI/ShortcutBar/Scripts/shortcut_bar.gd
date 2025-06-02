extends HBoxContainer

@onready var slots := get_children()


func _ready() -> void:
	update_selection()
	InventorySystem.drop_item.connect(update_selection)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey:
		var index = event.keycode - KEY_1
		if index in range(6) and event.is_pressed:
			select_slot(index)
	elif event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			select_slot((InventorySystem.selected_index + 1) % 6)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			select_slot((InventorySystem.selected_index - 1 + 6) % 6)


func select_slot(index: int) -> void:
	if index >= 0 and index < slots.size():
		InventorySystem.selected_index = index
		update_selection()


func update_selection() -> void:
	for i in range(slots.size()):
		if i == InventorySystem.selected_index:
			slots[i].modulate = Color.YELLOW
			InventorySystem.item_selected.emit(slots[i].inventory_item)
		else:
			slots[i].modulate = Color.WHITE

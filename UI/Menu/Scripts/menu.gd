extends Control

@onready var inventory_grid_container: GridContainer = %InventoryGridContainer

func _ready() -> void:
	visible = false
	EventSystem.item_collected.connect(add_item)
	
	for slot in inventory_grid_container.get_children():
		if slot is InventorySlot:
			slot.slot_double_clicked.connect(_on_inventory_slot_double_clicked)
			


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		visible = !visible
		MainInstance.player.active = !visible


func add_item(item: Item) -> void:
	if item.stackable:
		for child in inventory_grid_container.get_children():
			if child is InventorySlot and child.inventory_item != null:
				if child.inventory_item.item == item and child.inventory_item.quantity < item.max_stack:
					child.inventory_item.quantity += 1
					child.set_inventory_item(child.inventory_item)
					return
	
	for child in inventory_grid_container.get_children():
		if child is InventorySlot and child.inventory_item == null:
			var new_entry := InventoryItem.new()
			new_entry.item = item
			new_entry.quantity = 1
			child.set_inventory_item(new_entry)
			return

func _on_inventory_slot_double_clicked(slot: InventorySlot) -> void:
	if slot.inventory_item == null:
		return
	
	var shortcut_bar = get_tree().root.find_child("ShortcutBar", true, false)
	if shortcut_bar:
		for target in shortcut_bar.get_children():
			if target is InventorySlot and target.inventory_item == null:
				target.set_inventory_item(slot.inventory_item)
				slot.set_inventory_item(null)
				InventorySystem.force_update.emit()
				return

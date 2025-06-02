extends Control

@onready var grid_container: GridContainer = %InventoryGridContainer

func _ready() -> void:
	visible = false
	EventSystem.item_collected.connect(add_item)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_inventory"):
		visible = !visible


func add_item(item: Item) -> void:
	if item.stackable:
		for child in grid_container.get_children():
			if child is InventorySlot and child.inventory_item != null:
				if child.inventory_item.item == item and child.inventory_item.quantity < item.max_stack:
					child.inventory_item.quantity += 1
					child.set_inventory_item(child.inventory_item)
					return
	
	for child in grid_container.get_children():
		if child is InventorySlot and child.inventory_item == null:
			var new_entry := InventoryItem.new()
			new_entry.item = item
			new_entry.quantity = 1
			child.set_inventory_item(new_entry)
			return

class_name Player extends CharacterBody2D

@export var movement_stats: MovementStats

var current_tool: String
var current_inventory_item: InventoryItem = null:
	set(value):
		current_inventory_item = value
		if value != null and value.item.type == ItemConstants.ITEM_TYPE.TOOL:
			current_tool = value.item.item_name


func _ready() -> void:
	InventorySystem.item_selected.connect(_on_item_selected)


func _process(_delta: float) -> void:
	if velocity.x > 0.0:
		scale.x = scale.y * 1
	
	if velocity.x < 0.0:
		scale.x = scale.y * -1

func _on_item_selected(inventory_item: InventoryItem) -> void:
	current_inventory_item = inventory_item

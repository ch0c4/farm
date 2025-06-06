class_name Player extends CharacterBody2D

@export_category("Player stats")
@export var movement_stats: MovementStats

@export_category("Map info")
@export var ground_tilemap: TileMapLayer
@export var mouse_cursor: MouseCursor


var current_tool: String
var current_inventory_item: InventoryItem = null: set = set_current_inventory_item

func set_current_inventory_item(value: InventoryItem) -> void:
		current_inventory_item = value
		if value != null and value.item.type == ItemConstants.ITEM_TYPE.TOOL:
			current_tool = value.item.item_name


func _ready() -> void:
	MainInstance.player = self
	InventorySystem.item_selected.connect(set_current_inventory_item)


func _process(_delta: float) -> void:
	if velocity.x > 0.0:
		scale.x = scale.y * 1
	
	if velocity.x < 0.0:
		scale.x = scale.y * -1

class_name Player extends CharacterBody2D

@export_category("Player stats")
@export var movement_stats: MovementStats

var facing_direction: int = 1

var active := true
var can_dig := true

@export var current_tool: String
var current_inventory_item: InventoryItem = null: set = set_current_inventory_item

func set_current_inventory_item(value: InventoryItem) -> void:
	current_inventory_item = value
	if value != null and (value.item.type == ItemConstants.ITEM_TYPE.TOOL or value.item.type == ItemConstants.ITEM_TYPE.SEED):
		current_tool = value.item.item_name
	else:
		current_tool = ""


func _ready() -> void:
	MainInstance.player = self
	EventSystem.crop_mode.connect(set_crop_mode)
	InventorySystem.item_selected.connect(set_current_inventory_item)



func _process(_delta: float) -> void:
	flip_sprite()



func flip_sprite() -> void:
	if velocity.x > 0.0:
		facing_direction = 1
		scale.x = scale.y * 1
	
	if velocity.x < 0.0:
		facing_direction = -1
		scale.x = scale.y * -1


func set_crop_mode(value: bool) -> void:
	active = !value
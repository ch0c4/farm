class_name Player extends CharacterBody2D

@export_category("Player stats")
@export var movement_stats: MovementStats

@export_category("Map info")
@export var ground_tilemap: TileMapLayer
@export var tile_size := 16


@onready var target_tile: Marker2D = %TargetTile
@onready var ray_cast_2D: RayCast2D = $RayCast2D

var facing_direction: int = 1

var active := true
var can_dig := true

@export var current_tool: String
var current_inventory_item: InventoryItem = null: set = set_current_inventory_item

func set_current_inventory_item(value: InventoryItem) -> void:
		current_inventory_item = value
		if value != null and (value.item.type == ItemConstants.ITEM_TYPE.TOOL or value.item.type == ItemConstants.ITEM_TYPE.SEED):
			print(value.item.item_name)
			current_tool = value.item.item_name


func _ready() -> void:
	MainInstance.player = self
	InventorySystem.item_selected.connect(set_current_inventory_item)


func _process(_delta: float) -> void:
	flip_sprite()
	update_target_tile()

	can_dig = false if ray_cast_2D.is_colliding() else true


func update_target_tile() -> void:
	var player_pos = global_position

	var sprite_offset = Vector2(0, -0.5)

	if facing_direction == -1:
		sprite_offset = Vector2(-5, -0.5)
		
	player_pos += sprite_offset

	var offset = Vector2(facing_direction * tile_size, 0)
	var target_pos = player_pos + offset

	@warning_ignore("integer_division")
	var snapped_pos = Vector2(
		floor(target_pos.x / tile_size) * tile_size + tile_size / 2,
		floor(target_pos.y / tile_size) * tile_size + tile_size / 2,
	)

	target_tile.global_position = snapped_pos


func flip_sprite() -> void:
	if velocity.x > 0.0:
		facing_direction = 1
		scale.x = scale.y * 1
	
	if velocity.x < 0.0:
		facing_direction = -1
		scale.x = scale.y * -1

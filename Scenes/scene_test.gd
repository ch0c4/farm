extends Node2D

@onready var ui: CanvasLayer = $UI
@onready var ground: TileMapLayer = %Ground
@onready var mouse_cursor: Node2D = %MouseCursor


func _ready() -> void:
	ui.visible = true
	mouse_cursor.visible = false


func _process(_delta: float) -> void:
	var world_mouse_pos := get_global_mouse_position()
	var local_mouse_pos := ground.to_local(world_mouse_pos)
	var cell_coords := ground.local_to_map(local_mouse_pos)
	var tile_data: TileData = ground.get_cell_tile_data(cell_coords)
	mouse_cursor.tile_data = tile_data
	var tile_origin := ground.map_to_local(cell_coords)
	var tile_size := ground.tile_set.tile_size
	var tile_center := tile_origin + Vector2(tile_size) / 2

	mouse_cursor.position = tile_center

	

class_name MouseCursor extends Node2D

var tile_data: TileData

func _ready() -> void:
	MainInstance.mouse_cursor = self

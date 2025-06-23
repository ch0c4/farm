extends Node2D

@export var panel_scene: PackedScene
@export var radius := 3

@export var ground_tilemap: TileMapLayer

@onready var grid_panel_container: Node2D = $GridPanelContainer

var active_panels := []


func show_overlay(center_cell: Vector2i) -> void:
	clear_overlay()
	
	for x in range(-radius, radius + 1):
		for y in range(-radius, radius + 1):
			var cell = center_cell + Vector2i(x, y)
			var tile_data = ground_tilemap.get_cell_tile_data(Vector2i(x, y))
			if tile_data == null:
				continue
			
			var type = tile_data.get_custom_data("type")
			var panel = panel_scene.instantiate() as Panel
			panel.position = ground_tilemap.map_to_local(cell)
			panel.modulate = Color(0, 1, 0, 0.4) if type == 'crop' else Color(1, 0, 0, 0.4)
			grid_panel_container.add_child(panel)
			active_panels.append(panel)


func clear_overlay() -> void:
	for panel in grid_panel_container.get_children():
		panel.queue_free()
	active_panels.clear()

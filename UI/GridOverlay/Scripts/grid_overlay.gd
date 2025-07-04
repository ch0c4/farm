extends Node2D

@export var ground: TileMapLayer
@export var crop: TileMapLayer
@export var atlas_coords: Vector2i

@export var crop_scene: PackedScene

@onready var ghost_sprite: Sprite2D = $GhostSprite


var show_grid := false:
	set(value):
		show_grid = value
		EventSystem.crop_mode.emit(value)



func _ready() -> void:
	show_grid = false
	crop.tile_set.get_terrain_name(0,0)

	if MainInstance.get_current_inventory_item() == null:
		return
	
	if MainInstance.get_current_inventory_item().item.type != ItemConstants.ITEM_TYPE.SEED:
		return
	
	var current_item = MainInstance.get_current_inventory_item().item as Item
	ghost_sprite.texture = current_item.item_texture
	ghost_sprite.visible = false
	ghost_sprite.modulate.a = 0.5


func _process(_delta: float) -> void:
	if MainInstance.get_current_inventory_item() == null:
		return
	
	show_grid = Input.is_action_pressed("interact") and MainInstance.get_current_inventory_item().item.type == ItemConstants.ITEM_TYPE.SEED
	ghost_sprite.texture = MainInstance.get_current_inventory_item().item.item_texture
	ghost_sprite.visible = show_grid

	if show_grid:
		var mouse_pos = ground.get_local_mouse_position()
		var cell = ground.local_to_map(mouse_pos)
		var cell_pos = ground.map_to_local(cell)

		var tile_size = ground.tile_set.tile_size
		ghost_sprite.position = cell_pos + Vector2(tile_size) / 2
	
	queue_redraw()


func _input(event: InputEvent) -> void:
	if not show_grid:
		return
	
	if event is InputEventMouseButton:
		place_tile()


func _draw() -> void:
	if not show_grid:
		return
	
	var tile_size = ground.tile_set.tile_size
	var used_rect = ground.get_used_rect()
	var visible_rect = Rect2(
		used_rect.position * tile_size,
		used_rect.size * tile_size
	)

	for x in range(int(visible_rect.position.x), int(visible_rect.end.x), tile_size.x):
		draw_line(Vector2(x, visible_rect.position.y), Vector2(x, visible_rect.end.y), Color(1, 1, 1, 0.5))
	
	for y in range(int(visible_rect.position.y), int(visible_rect.end.y), tile_size.y):
		draw_line(Vector2(visible_rect.position.x, y), Vector2(visible_rect.end.x, y), Color(1, 1, 1, 0.5))

	
func place_tile() -> void:
	var mouse_pos = ground.get_global_mouse_position()
	var cell = ground.local_to_map(mouse_pos)

	crop.set_cells_terrain_connect([cell], 0, 0)

	var p = ground.map_to_local(cell)
	var c = crop_scene.instantiate() as Crop
	c.global_position = p
	c.current_crop = MainInstance.get_current_inventory_item().item.crop
	get_tree().current_scene.add_child(c)

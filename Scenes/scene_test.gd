extends Node2D

const FISHING_MINI_GAME = preload("res://Scenes/FishingMiniGame/fishing_mini_game.tscn")
const CROP_SCENE = preload("res://Entities/Collectables/Crop/crop.tscn")

@onready var ui: CanvasLayer = $UI
@onready var construction_overlay: Node2D = %ConstructionOverlay
@onready var ground: TileMapLayer = %Ground

var fishing_game: Control

var construction_mode := false


func _ready() -> void:
	ui.visible = true
	EventSystem.start_fishing_mini_game.connect(start_fish_mini_game)
	EventSystem.end_fishing_mini_game.connect(end_fish_mini_game)
	EventSystem.start_construction_mode.connect(start_construction_mode)


func _input(event: InputEvent) -> void:
	if construction_mode:
		var mouse_pos := get_global_mouse_position()
		var cell := ground.local_to_map(ground.to_local(mouse_pos))
		construction_overlay.visible = true
		construction_overlay.show_overlay(cell)
		
		if event.is_action_pressed("interact"):
			try_place_crop(cell)
		
		if event.is_action("exit_current"):
			end_construction_mode()


func start_fish_mini_game() -> void:
	get_tree().paused = true
	PhysicsServer2D.set_active(true)
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	fishing_game = FISHING_MINI_GAME.instantiate()
	get_tree().current_scene.add_child(fishing_game)


func end_fish_mini_game(_success: bool) -> void:
	fishing_game.queue_free()


func start_construction_mode() -> void:
	get_tree().paused = true
	construction_mode = true


func end_construction_mode() -> void:
	get_tree().paused = false
	construction_mode = false
	EventSystem.end_construction_mode.emit()


func try_place_crop(cell: Vector2i) -> void:
	var tile_data := ground.get_cell_tile_data(cell)
	
	if tile_data == null:
		return
	
	if tile_data.get_custom_data("type") != "crop":
		return
	
	var crop := CROP_SCENE.instantiate()
	crop.position = ground.map_to_local(cell)
	add_child(crop)
	

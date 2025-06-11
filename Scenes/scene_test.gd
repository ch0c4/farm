extends Node2D

const FISHING_MINI_GAME = preload("res://Scenes/FishingMiniGame/fishing_mini_game.tscn")

@onready var ui: CanvasLayer = $UI
@onready var ground: TileMapLayer = %Ground


func _ready() -> void:
	ui.visible = true
	EventSystem.start_fishing_mini_game.connect(start_fish_mini_game)


func start_fish_mini_game() -> void:
	get_tree().paused = true
	PhysicsServer2D.set_active(true)
	
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	
	var fishing_game = FISHING_MINI_GAME.instantiate()
	get_tree().current_scene.add_child(fishing_game)

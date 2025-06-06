extends Node2D

@onready var ui: CanvasLayer = $UI
@onready var ground: TileMapLayer = %Ground


func _ready() -> void:
	ui.visible = true


	

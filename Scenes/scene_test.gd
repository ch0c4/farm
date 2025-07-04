extends Node2D

const FISHING_MINI_GAME = preload("res://Scenes/FishingMiniGame/fishing_mini_game.tscn")

@onready var ui: CanvasLayer = $UI


func _ready() -> void:
	ui.visible = true

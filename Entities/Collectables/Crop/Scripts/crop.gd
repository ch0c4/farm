class_name Crop extends Node2D

const SOILS: Array[Texture2D] = [
	preload("res://Entities/Collectables/Crop/Assets/soil_00.png"),
	preload("res://Entities/Collectables/Crop/Assets/soil_01.png"),
	preload("res://Entities/Collectables/Crop/Assets/soil_02.png"),
	preload("res://Entities/Collectables/Crop/Assets/soil_03.png")
]

@onready var soil: Sprite2D = $Soil

var current_crop: Crops

var nb_day_of_growning := 0

func _ready() -> void:
	soil.texture = SOILS[0]
	

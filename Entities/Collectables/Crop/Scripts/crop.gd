class_name Crop extends Node2D

@export var crops: Crops:
	set(value):
		crops = value
		print(crops)


func _ready() -> void:
	z_index = -1

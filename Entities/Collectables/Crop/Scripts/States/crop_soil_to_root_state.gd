extends State

@export var soil_sprite: Sprite2D
@export var crop_sprite: Sprite2D

@export var soil_texture: Texture2D

@onready var crop: Crop = get_owner()


func enter() -> void:
	TimeSystem.new_day.connect(_on_day_changed)
	crop.z_index = -1
	crop_sprite.texture = null
	soil_sprite.texture = soil_texture


func exit() -> void:
	TimeSystem.new_day.disconnect(_on_day_changed)


func _on_day_changed(_day_count: int) -> void:
	transitionned.emit(self, "Root_0")
extends State

@export var soil_texture: Texture2D
@export var hurtbox: Hurtbox
@export var soil_sprite: Sprite2D
@export var crop_sprite: Sprite2D
@export var tool: String
@export var next_state: String

@onready var crop: Crop = get_owner()

func enter() -> void:
	hurtbox.hurt.connect(_on_soil_hurt)
	crop.z_index = -1
	crop_sprite.texture = null
	soil_sprite.texture = soil_texture


func exit() -> void:
	hurtbox.hurt.disconnect(_on_soil_hurt)


func _on_soil_hurt(hitbox: Hitbox) -> void:
	if hitbox.get_parent() is Player and hitbox.get_parent().current_tool == tool:
		transitionned.emit(self, next_state)

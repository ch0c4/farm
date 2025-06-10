extends State

@export var hurtbox: Hurtbox
@export var crop_sprite: Sprite2D
@export var crop_index := 4

@onready var crop: Crop = get_owner()


func enter() -> void:
	hurtbox.hurt.connect(_on_crop_hurt)
	crop_sprite.texture = crop.crops.crops_textures[crop_index]


func exit() -> void:
	hurtbox.hurt.disconnect(_on_crop_hurt)


func _on_crop_hurt(hitbox: Hitbox) -> void:
	if hitbox.get_parent() is Player and hitbox.get_parent().current_tool == "Shovel":
		for i in range(crop.crops.nb_spawn_crop):
			var root_instance = crop.crops.spawn_crop_item.instantiate()
			crop.get_tree().current_scene.add_child(root_instance)
			root_instance.global_position = crop.global_position
		
		crop.call_deferred("queue_free")

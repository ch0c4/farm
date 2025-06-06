extends State

@export var anim_name: String
@export var animation_player: AnimationPlayer
@export var hitbox: Hitbox
@export var crop_scene: PackedScene

@onready var player: Player = get_owner()

var dig_position: Vector2

var dug_tiles = {}

func enter() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play(anim_name)
	dig_position = MainInstance.mouse_cursor.position


func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)


func _on_animation_finished(_anim_name: StringName) -> void:
	try_dig()
	transitionned.emit(self, "Idle")


func try_dig() -> void:
	var ground_tilemap = player.ground_tilemap
	if ground_tilemap == null:
		return

	var tile_data := player.mouse_cursor.tile_data
	
	if tile_data != null:
		if tile_data.get_custom_data("can_crop"):
			var crop_instance := crop_scene.instantiate()
			crop_instance.global_position = dig_position
			get_tree().current_scene.add_child(crop_instance)

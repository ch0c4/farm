extends State

@export var anim_name: String
@export var animation_player: AnimationPlayer
@export var hitbox: Hitbox
@export var crop_scene: PackedScene
@export var dig_origin: Marker2D

@onready var player: Player = get_owner()

var dig_position: Vector2

var dug_tiles = {}

func enter() -> void:
	animation_player.animation_finished.connect(_on_animation_finished)
	animation_player.play(anim_name)

	await get_tree().process_frame
	
	dig_position = dig_origin.global_position
	print("dig_position", dig_position)
	print("collision position", hitbox.get_node("CollisionShape2D").global_position)



func exit() -> void:
	animation_player.animation_finished.disconnect(_on_animation_finished)


func _on_animation_finished(_anim_name: StringName) -> void:
	transitionned.emit(self, "Idle")


func try_dig() -> void:
	var ground_tilemap = player.ground_tilemap
	if ground_tilemap == null:
		return

	var local_dig_pos := player.ground_tilemap.to_local(dig_position)
	var cell_coords := player.ground_tilemap.local_to_map(local_dig_pos)

	if dug_tiles.has(cell_coords):
		return

	
	var tile_data := ground_tilemap.get_cell_tile_data(cell_coords)
	if tile_data != null:
		if tile_data.get_custom_data("can_crop"):
			var crop_instance := crop_scene.instantiate()

			var tile_center := ground_tilemap.map_to_local(cell_coords) + Vector2(ground_tilemap.tile_set.tile_size) / 2
			crop_instance.global_position = ground_tilemap.to_global(tile_center)

			get_tree().current_scene.add_child(crop_instance)

			dug_tiles[cell_coords] = true

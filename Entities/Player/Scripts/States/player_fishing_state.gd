extends State

@export var hitbox: Hitbox
@export var animation_player: AnimationPlayer
@export var target_tile: Marker2D

@onready var player: Player = get_owner()

var is_reeling := false


func enter() -> void:
	EventSystem.end_fishing_mini_game.connect(_on_fishing_end)
	is_reeling = false
	animation_player.play("casting")


func exit() -> void:
	EventSystem.end_fishing_mini_game.disconnect(_on_fishing_end)


func update(_delta: float) -> void:
	if is_reeling and Input.is_action_just_pressed("interact"):
		transitionned.emit(self, "Idle")


func on_fishing() -> void:
	var lake_tilemap = player.lake_tilemap
	if lake_tilemap == null:
		return
	
	var local_dig_pos := lake_tilemap.to_local(target_tile.global_position)
	var cell_coords := lake_tilemap.local_to_map(local_dig_pos)
	
	var tile_data := lake_tilemap.get_cell_tile_data(cell_coords)
	if tile_data != null and tile_data.get_custom_data("can_fish"):
		animation_player.play("waiting")
		
		await get_tree().create_timer(randi_range(3, 6)).timeout
		
		animation_player.play("reeling")
		
		EventSystem.start_fishing_mini_game.emit()
	else:
		transitionned.emit(self, "Idle")


func _on_fishing_end(success: bool) -> void:
	if not success:
		transitionned.emit(self, "Idle")
	else:
		pass

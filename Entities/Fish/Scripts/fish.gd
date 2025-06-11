extends CharacterBody2D

@export var movement_stats: MovementStats
@export var aqua_container: Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var target_position: Vector2
var border_distance := 10

func _ready() -> void:
	_set_target_position()


func _physics_process(delta: float) -> void:
	var direction := (target_position - global_position).normalized()
	
	if direction:
		CharacterMover.accelerate_in_direction(self, direction, movement_stats, delta)
	else:
		CharacterMover.decelerate(self, movement_stats, delta)
	
	if global_position.distance_to(target_position) < 5:
		_on_target()
	
	_set_animation()
	_flip_sprite()
	
	CharacterMover.move(self)


func _on_target() -> void:
	set_physics_process(false)
	await get_tree().create_timer(1.5).timeout
	
	_set_new_target_position()
	
	set_physics_process(true)


func _set_target_position() -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	
	_set_new_target_position()


func _set_new_target_position() -> void:
	var box_size := aqua_container.get_global_rect()
	var x_position := randf_range(
		box_size.position.x + border_distance, 
		box_size.position.x + box_size.size.x - border_distance
	)
	var y_position := randf_range(
		box_size.position.y + border_distance, 
		box_size.position.y + box_size.size.y - border_distance
	)
	
	target_position = Vector2(x_position, y_position)


func _flip_sprite() -> void:
	if velocity.x > 0.0:
		scale.x = scale.y * 1
	
	if velocity.x < 0.0:
		scale.x = scale.y * -1


func _set_animation() -> void:
	if velocity:
		animation_player.play("move")
	else:
		animation_player.play("idle")

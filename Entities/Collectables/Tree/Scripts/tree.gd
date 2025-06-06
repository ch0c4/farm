extends StaticBody2D

@export var stats: Stats
@export var log_scene: PackedScene
@export var trunk_scene: PackedScene
@export var tool_to_collect: String = "Axe"

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Hurtbox = $Hurtbox


func _ready() -> void:
	hurtbox.hurt.connect(_on_hurtbox_hurt)
	animated_sprite.animation_finished.connect(_on_animation_finished)
	stats.no_health.connect(_on_no_health)
	hurtbox.is_invincible = false


func spawn_log() -> void:
	var log_instance = log_scene.instantiate()
	call_deferred("_add_log", log_instance)

	
func _add_log(log_instance: Node2D) -> void:
	get_tree().current_scene.add_child(log_instance)
	log_instance.global_position = global_position

	var random_angle = randf_range(0, TAU)
	var direction = Vector2(cos(random_angle), sin(random_angle))

	if log_instance is RigidBody2D:
		log_instance.linear_velocity = direction * 200.0


func _on_animation_finished() -> void:
	hurtbox.is_invincible = false
	animated_sprite.play("idle")


func _on_no_health() -> void:
	spawn_log()
	
	var trunk_instance = trunk_scene.instantiate()
	get_tree().current_scene.add_child(trunk_instance)
	trunk_instance.global_position = global_position
	
	call_deferred("queue_free")

func _on_hurtbox_hurt(hitbox: Hitbox) -> void:
	if hitbox.get_parent() is Player and hitbox.get_parent().current_tool == tool_to_collect:
		hurtbox.is_invincible = true
		animated_sprite.play("chopped")
		spawn_log()
		stats.health -= hitbox.damage

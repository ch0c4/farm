extends StaticBody2D

@export_category("Stats")
@export var stats: Stats

@export_category("Spawn")
@export var common_gem_scene: PackedScene
@export var rare_gem_scene: PackedScene
@export var tool_to_collect: String = "Pickaxe"

@export_category("Texture")
@export var full_texture: Texture2D
@export var half_texture: Texture2D
@export var empty_texture: Texture2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hurtbox: Hurtbox = $Hurtbox
@onready var timer: Timer = $Timer

var max_health: float = 10.0


func _ready() -> void:
	hurtbox.hurt.connect(_on_hurtbox_hurt)
	stats.no_health.connect(_on_no_health)
	timer.timeout.connect(init)
	max_health = stats.max_health
	init()


func init() -> void:
	stats.health = max_health
	hurtbox.is_invincible = false
	sprite_2d.texture = full_texture


func spawn_gem() -> void:
	var gem_instance: Node2D

	if randf() < 0.9:
		gem_instance = common_gem_scene.instantiate()
	else:
		gem_instance = rare_gem_scene.instantiate()
	
	call_deferred("_add_gem", gem_instance)

	
func _add_gem(gem_instance: Node2D) -> void:
	get_tree().current_scene.add_child(gem_instance)
	gem_instance.global_position = global_position

	var random_angle = randf_range(0, TAU)
	var direction = Vector2(cos(random_angle), sin(random_angle))

	if gem_instance is RigidBody2D:
		gem_instance.linear_velocity = direction * 200.0


func _on_no_health() -> void:
	sprite_2d.texture = empty_texture
	hurtbox.is_invincible = true
	timer.start()


func _on_hurtbox_hurt(hitbox: Hitbox) -> void:
	if (hitbox.get_parent() is Player 
		and hitbox.get_parent().current_tool == tool_to_collect):
		
		hurtbox.is_invincible = true
		if stats.health - hitbox.damage <= stats.max_health / 2:
			sprite_2d.texture = half_texture
		spawn_gem()
		await get_tree().create_timer(0.3).timeout
		hurtbox.is_invincible = false
		stats.health -= hitbox.damage

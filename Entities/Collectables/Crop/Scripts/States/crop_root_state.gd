extends State

@export var hurtbox: Hurtbox
@export var crop_sprite: Sprite2D
@export var animation_player: AnimationPlayer
@export var crop_index := 0
@export var next_state: String

@onready var crop: Crop = get_owner()

var is_watered := false
var watered_days := 0

func enter() -> void:
	hurtbox.hurt.connect(_on_crop_hurt)
	TimeSystem.new_day.connect(_on_day_changed)
	animation_player.play("not_watered")
	crop.z_index = 0
	is_watered = false
	watered_days = 0
	crop_sprite.texture = crop.crops.crops_textures[crop_index]


func exit() -> void:
	hurtbox.hurt.disconnect(_on_crop_hurt)
	TimeSystem.new_day.disconnect(_on_day_changed)


func _on_day_changed(_day_count: int) -> void:
	if is_watered:
		watered_days += 1
		is_watered = false
	
	animation_player.play("no_watered")
	
	var growth_days_per_stage := crop.crops.nb_day_of_growning / 5.0
	
	if watered_days >= growth_days_per_stage:
		transitionned.emit(self, next_state)


func _on_crop_hurt(hitbox: Hitbox) -> void:
	if hitbox.get_parent() is Player and hitbox.get_parent().current_tool == "Watering Can":
		animation_player.play("watered")
		is_watered = true

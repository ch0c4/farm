extends State


@export var hitbox: Hitbox
@export var animation_player: AnimationPlayer


@onready var player: Player = get_owner()


func enter() -> void:
	animation_player.animation_finished.connect(_on_doing_animation_finish)
	hitbox.hit_hurtbox.connect(_on_hit_hurtbox)
	animation_player.play("doing")


func exit() -> void:
	animation_player.animation_finished.disconnect(_on_doing_animation_finish)
	hitbox.hit_hurtbox.disconnect(_on_hit_hurtbox)


func _on_hit_hurtbox(hurtbox: Hurtbox) -> void:
	if hurtbox.get_parent() is Crop:
		hurtbox.get_parent().crops = ItemConstants.CROP_LIST[player.current_tool]


func _on_doing_animation_finish(_anim_name: StringName) -> void:
	transitionned.emit(self, "Idle")

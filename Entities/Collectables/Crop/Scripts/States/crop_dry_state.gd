extends State


@export var seed_sprite: Sprite2D
@export var hurtbox: Hurtbox
@export var animation_player: AnimationPlayer


@onready var crop: Crop


func enter() -> void:
    hurtbox.hurt.connect(_on_water)
    animation_player.play("watered_to_dry")
    if crop.nb_day_of_growning == 0:
        seed_sprite.texture = crop.current_crop.crops_textures[0]


func exit() -> void:
    hurtbox.hurt.disconnect(_on_water)


func _on_water(other_hitbox: Hitbox) -> void:
    if other_hitbox.get_parent() is not Player:
        return
    
    var player = other_hitbox.get_parent() as Player
    if player.current_tool == "Watering Can":
        transitionned.emit(self, "Watered")
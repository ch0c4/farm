extends State


@export var soil: Sprite2D
@export var hurtbox: Hurtbox

@onready var crop: Crop = get_owner()


func enter() -> void:
    hurtbox.hurt.connect(_on_seeding)
    soil.texture = crop.SOILS[3]


func exit() -> void:
    hurtbox.hurt.disconnect(_on_seeding)
 

func _on_seeding(other_hitbox: Hitbox) -> void:
    if other_hitbox.get_parent() is not Player:
        return
    
    var player = other_hitbox.get_parent() as Player
    if player.current_inventory_item.item.type == ItemConstants.ITEM_TYPE.SEED:
        transitionned.emit(self, "Dry")
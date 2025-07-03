extends State

@export var hurtbox: Hurtbox

func enter() -> void:
    hurtbox.hurt.connect(_on_dig_soil)


func exit() -> void:
    hurtbox.hurt.disconnect(_on_dig_soil)


func _on_dig_soil(other_hitbox: Hitbox) -> void:
    if other_hitbox.get_parent() is not Player:
        return
    
    var player = other_hitbox.get_parent() as Player
    if  player.current_tool == "Shovel":
        transitionned.emit(self, "Seedable")
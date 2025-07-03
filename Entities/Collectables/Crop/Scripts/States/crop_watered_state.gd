extends State


@export var animation_player: AnimationPlayer

@onready var crop: Crop = get_owner()


func enter() -> void:
    TimeSystem.new_day.connect(_on_new_day)
    animation_player.play("dry_to_watered")


func exit() -> void:
    TimeSystem.new_day.disconnect(_on_new_day)


func _on_new_day(_day_count: int) -> void:
    crop.nb_day_of_growning += 1
    transitionned.emit(self, "Dry")
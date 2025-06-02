extends State

@export var anim_name: String
@export var animation_player: AnimationPlayer

func enter() -> void:
    animation_player.animation_finished.connect(_on_animation_finished)
    animation_player.play(anim_name)


func exit() -> void:
    animation_player.animation_finished.disconnect(_on_animation_finished)


func _on_animation_finished(_anim_name: StringName) -> void:
    transitionned.emit(self, "Idle")

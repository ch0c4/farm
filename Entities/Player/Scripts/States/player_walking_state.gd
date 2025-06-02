extends State

@export var animation_player: AnimationPlayer

@onready var player: Player = get_owner()


func enter() -> void:
	animation_player.play("walking")


func physics_update(delta: float) -> void:
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if input_vector == Vector2.ZERO:
		transitionned.emit(self, "Idle")
	else:
		CharacterMover.accelerate_in_direction(player, input_vector.normalized(), player.movement_stats, delta)
		CharacterMover.move(player)
	
	if Input.is_action_just_pressed("interact"):
		match player.current_tool:
			"Axe":
				transitionned.emit(self, "Axe")
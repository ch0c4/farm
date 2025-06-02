extends State

@export var animation_player: AnimationPlayer

@onready var player: Player = get_owner()

var input_vector: Vector2


func enter() -> void:
	InventorySystem.item_selected.connect(_on_item_selected)
	animation_player.play("carry")


func exit() -> void:
	InventorySystem.item_selected.disconnect(_on_item_selected)


func physics_update(delta: float) -> void:
	input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if input_vector == Vector2.ZERO:
		CharacterMover.decelerate(player, player.movement_stats, delta)
	else:
		CharacterMover.accelerate_in_direction(player, input_vector.normalized(), player.movement_stats, delta)
	
	CharacterMover.move(player)


func _on_item_selected(inventory_item: InventoryItem) -> void:
	if inventory_item != null and inventory_item.item.type != ItemConstants.ITEM_TYPE.RESOURCE:
		if input_vector != Vector2.ZERO:
			transitionned.emit(self, "Walking")
		else:
			transitionned.emit(self, "Idle")
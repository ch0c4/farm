extends State

@export var animation_player: AnimationPlayer

@onready var player: Player = get_owner()


func enter() -> void:
	animation_player.play("idle")
	InventorySystem.item_selected.connect(_on_item_selected)


func exit() -> void:
	InventorySystem.item_selected.disconnect(_on_item_selected)


func physics_update(delta: float) -> void:
	if not player.active:
		return
	
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	if input_vector != Vector2.ZERO:
		transitionned.emit(self, "Walking")
	else:
		CharacterMover.decelerate(player, player.movement_stats, delta)
		CharacterMover.move(player)
	
	if Input.is_action_just_pressed("interact"):
		if player.current_tool.to_lower().contains("seed"):
			transitionned.emit(self, "Seed")
		else:
			match player.current_tool:
				"Axe":
					transitionned.emit(self, "Axe")
				"Hammer":
					transitionned.emit(self, "Hammering")
				"Pickaxe":
					transitionned.emit(self, "Mining")
				"Shovel":
					transitionned.emit(self, "Dig")
				"Watering Can":
					transitionned.emit(self, "Watering")
				"Fishing Rod":
					transitionned.emit(self, "Fishing")
				_:
					transitionned.emit(self, "Doing")


func _on_item_selected(inventory_item: InventoryItem) -> void:
	if inventory_item != null and inventory_item.item.type == ItemConstants.ITEM_TYPE.RESOURCE:
		transitionned.emit(self, "Carry")

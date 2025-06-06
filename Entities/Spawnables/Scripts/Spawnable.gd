extends RigidBody2D

@onready var area_2d: Area2D = $Area2D

@export var item: Item


func _ready() -> void:
	area_2d.body_entered.connect(_on_collect)


func _on_collect(body: Node2D) -> void:
	if body is Player:
		EventSystem.item_collected.emit(item)
		call_deferred("queue_free")

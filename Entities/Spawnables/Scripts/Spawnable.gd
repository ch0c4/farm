@tool
extends RigidBody2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D

@export var item: Item:
	set(value):
		item = value
		if sprite_2d:
			sprite_2d.texture = item.item_texture
		elif is_inside_tree():
			var sprite = get_node_or_null("Sprite2D")
			if sprite:
				sprite.texture = item.item_texture


func _ready() -> void:
	area_2d.body_entered.connect(_on_collect)


func _on_collect(body: Node2D) -> void:
	if body is Player:
		EventSystem.item_collected.emit(item)
		call_deferred("queue_free")

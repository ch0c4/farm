class_name Item extends Resource

@export var item_name: String
@export_multiline var description: String

@export var item_texture: Texture2D

@export var type: ItemConstants.ITEM_TYPE
@export var uses: Array[ItemConstants.ITEM_USE]
@export var rarity: ItemConstants.ITEM_RARITY
@export var stackable: bool = true
@export_range(1, 99) var max_stack: int = 99

@export var price: int = 1

@export var crop: Crops

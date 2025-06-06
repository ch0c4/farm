@tool
class_name InventorySlot extends NinePatchRect

const DOUBLE_CLICK_TIME := 0.3

signal slot_double_clicked(slot: InventorySlot)

@onready var texture_rect: TextureRect = $TextureRect
@onready var quantity_label: Label = $Label

@export var inventory_item: InventoryItem: set = set_inventory_item

@export var drag_preview_pivot_offset := Vector2(5.0, 5.0)

var _last_click_time := 0.0
var item_data = null


func set_inventory_item(value: InventoryItem) -> void:
	inventory_item = value
	item_data = value

	var tex_rect = texture_rect
	if tex_rect == null and is_inside_tree():
		tex_rect = get_node_or_null("TextureRect")
	
	if tex_rect:
		if value != null:
			tex_rect.texture = value.item.item_texture
		else:
			tex_rect.texture = null
	
	var ql = quantity_label
	if ql == null and is_inside_tree():
		ql = get_node_or_null("Label")
	
	if ql:
		if value == null:
			ql.visible = false
		else:
			ql.visible = value.item.stackable
			if value.item.stackable:
				ql.text = str(value.quantity)
	

func _ready() -> void:
	quantity_label.visible = false


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		print("click")
		var now = Time.get_ticks_msec() / 1000.0
		if now - _last_click_time < DOUBLE_CLICK_TIME:
			slot_double_clicked.emit(self)
		_last_click_time = now

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return (typeof(data) == TYPE_DICTIONARY 
		and data.has("item_data") 
		and data.has("source_slot"))


func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var source_slot = data.source_slot

	if source_slot == self:
		return
	
	var incoming_data = data.item_data
	var temp = item_data

	set_inventory_item(incoming_data)
	source_slot.set_inventory_item(temp)
	InventorySystem.force_update.emit()


func _get_drag_data(_at_position: Vector2) -> Variant:
	if item_data == null:
		return null

	var drag_preview = TextureRect.new()
	drag_preview.scale = Vector2(6.0, 6.0)
	drag_preview.z_index = 999
	drag_preview.texture = item_data.item.item_texture

	drag_preview.set_anchors_preset(Control.LayoutPreset.PRESET_CENTER)
	drag_preview.pivot_offset = drag_preview_pivot_offset

	set_drag_preview(drag_preview)

	return {"item_data": item_data, "source_slot": self}

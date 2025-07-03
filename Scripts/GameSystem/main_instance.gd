extends Node

var player: Player


func get_current_inventory_item() -> InventoryItem:
    if not player:
        return null
    
    if not player.current_inventory_item:
        return null
    
    return player.current_inventory_item
extends Node

# Item Types
enum ITEM_TYPE {
	RESOURCE,
	TOOL,
	SEED,
	CROP,
	ANIMAL_PRODUCT,
	BUILDING,
	CONSUMABLE
}

# Item Uses
enum ITEM_USE {
	BUILDING,
	CRAFTING,
	FUEL,
	PLANTING,
	HARVESTING,
	EATING,
	SELLING,
	FISHING
}

# Rarity Levels
enum ITEM_RARITY {
	COMMON,
	UNCOMMON,
	RARE,
	EPIC,
	LEGENDARY,
}

const CROP_LIST = {
	"Beetroot Seeds": preload("res://Resources/Resources/Crops/crop_beetroot.tres")
}

@tool 
extends Node2D

@onready var base: Sprite2D = $Base
@onready var hair: Sprite2D = $Hair
@onready var tool: Sprite2D = $Tool

@export var base_texture: Texture2D = preload("res://Entities/Player/Assets/IDLE/base_idle_strip9.png"):
	set(value):
		base_texture = value
		base.texture = value

@export var hair_texture: Texture2D = preload("res://Entities/Player/Assets/IDLE/spikeyhair_idle_strip9.png"):
	set(value):
		hair_texture = value
		hair.texture = value

@export var tool_texture: Texture2D = preload("res://Entities/Player/Assets/IDLE/tools_idle_strip9.png"):
	set(value):
		tool_texture = value
		tool.texture = value

@export var hframes: int = 9:
	set(value):
		hframes = value
		base.hframes = value
		hair.hframes = value
		tool.hframes = value

@export var vframes: int = 1:
	set(value):
		vframes = value
		base.vframes = value
		hair.vframes = value
		tool.vframes = value

@export var frame: int = 0:
	set(value):
		frame = value
		base.frame = value
		hair.frame = value
		tool.frame = value

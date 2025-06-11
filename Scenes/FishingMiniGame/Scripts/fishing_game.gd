extends Control

@export var progress_bar_danger_texture: Texture2D
@export var progress_bar_warning_texture: Texture2D
@export var progress_bar_success_texture: Texture2D

@onready var catch_bar: TextureProgressBar = %CatchBar
@onready var target: Area2D = %Target

var on_catch := false
var catch_speed := 0.3
var catching_value := 30.0:
	set(value):
		catching_value = value
		if value <= 30.0:
			catch_bar.texture_progress = progress_bar_danger_texture
		elif value > 30.0 and value <= 50.0:
			catch_bar.texture_progress = progress_bar_warning_texture
		else:
			catch_bar.texture_progress = progress_bar_success_texture


func _ready() -> void:
	target.target_entered.connect(_on_target_entered)
	target.target_exited.connect(_on_target_exited)
	catch_bar.value = catching_value


func _physics_process(_delta: float) -> void:
	if on_catch:
		catching_value += catch_speed
	else:
		catching_value -= catch_speed
		
	if catching_value <= 0:
		_game_end(false)
	if catching_value >= 100.0:
		_game_end(true)
	
	catch_bar.value = catching_value


func _game_end(success: bool) -> void:
	var tween = get_tree().create_tween()
	
	tween.set_pause_mode(Tween.TWEEN_PAUSE_PROCESS)
	tween.tween_property(self, "global_position", global_position + Vector2(0, 700), 0.5)
	
	await tween.finished
	
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = false
	
	EventSystem.end_fishing_mini_game.emit(success)
	queue_free()


func _on_target_entered() -> void:
	on_catch = true


func _on_target_exited() -> void:
	on_catch = false

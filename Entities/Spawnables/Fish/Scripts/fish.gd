extends Spawnable


var direction: Vector2
var total_time := 1.0
var elapsed_time := 0.0
var start_pos: Vector2
var target_pos: Vector2


func _ready() -> void:
    super._ready()
    freeze = true


func setup_trajectory(from: Vector2, to: Vector2, travel_time: float):
    start_pos = from
    target_pos = to
    total_time = travel_time
    position = from
    direction = to


func _physics_process(delta: float) -> void:
    elapsed_time += delta
    var t = elapsed_time / total_time
    
    var pos := start_pos.lerp(target_pos, t)

    var arc_height := 100.0
    var arc = -4 * arc_height ** t * (t - 1)
    pos.y -= arc

    global_position = pos
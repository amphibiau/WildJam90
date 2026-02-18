extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var existence_timer: Timer = $existence_timer

signal hit
signal miss

var note_hit = false # used to track so theres no double signal call from miss collider
var enable_miss_hitbox = false # for testing, this might be annoying as fuck?

func _ready():
	animation_player.speed_scale = Gamestate.current_bpm / 60
	animation_player.play("spawning")

func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	note_hit = true
	animation_player.speed_scale = 1.0
	animation_player.play("hit")
	
	hit.emit()

func start_existence():
	existence_timer.wait_time = Gamestate.beat_length * Gamestate.note_existence_length
	existence_timer.start()

func note_missed():
	animation_player.speed_scale = 1.0
	animation_player.play("miss")
	
	miss.emit()

func _on_area_miss_collider_mouse_shape_exited(shape_idx: int) -> void:
	if !note_hit && enable_miss_hitbox: # if the inner collider wasn't touched upon outer exit
		note_missed()

func _on_existence_timer_timeout() -> void:
	note_missed()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"spawning": start_existence()
		"hit": queue_free()
		"miss": queue_free()

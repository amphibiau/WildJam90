extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var existence_timer: Timer = $existence_timer

signal hit
signal miss

func _ready():
	animation_player.speed_scale = Gamestate.current_bpm / 60
	animation_player.play("spawning")

func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	animation_player.speed_scale = 1.0
	animation_player.play("hit")
	
	hit.emit()

func start_existence():
	existence_timer.wait_time = Gamestate.beat_length * Gamestate.note_existence_length
	existence_timer.start()

func _on_existence_timer_timeout() -> void:
	animation_player.speed_scale = 1.0
	animation_player.play("miss")
	
	miss.emit()

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	match anim_name:
		"spawning": start_existence()
		"hit": queue_free()
		"miss": queue_free()

extends Node2D

@onready var conductor: AnimationPlayer = $conductor

@export var note_area : Node2D

var grouping_spawn_pos = Vector2(0,0) # percentage between 0 and 100%

@onready var viewport_size = get_viewport().size

# just putting these here for now
# group loading
const NOTE_GROUP_HORIZONTAL = preload("uid://4xwpiyf7vc0a")
const NOTE_GROUP_VERTICAL = preload("uid://nnfnpxbllb62")
const NOTE_GROUP_DIAG_UP = preload("uid://u8lglrihhur4")
const NOTE_GROUP_DIAG_DOWN = preload("uid://b52y8y2feytq6")
const NOTE_GROUP_CURVE_UP = preload("uid://bv0ay11olua0s")
const NOTE_GROUP_CURVE_DOWN = preload("uid://brewv3vxx0xpu")

# this will need to be able to load a song based upon what is stored and it name under an
# enum, for right now it will just fucking autostart

# note that when spawning notes in the conductor, they should be
# 1. snapping should be set to increments of seconds that equal the bpm, specifcally 60 / bpm
# 2. a beat ahead of where they are intended to spawn

# for ex, current song is 125 bpm so snapping is set to 0.48

func _ready():
	conductor.play("that 90's feelin"); conductor.pause()
	conductor.advance(Gamestate.debug_start_time)
	conductor.play()

func _add_group(group : Enums.Groups, position : Vector2): # position is by canvas percentage
	var grouping_spawn_pos = position
	var group_tscn = fetch_group(group)
	
	var group_instance = group_tscn.instantiate()
	note_area.add_child(group_instance)
	group_instance.global_position = _fetch_canvas_pos_by_percent(position)

func _fetch_canvas_pos_by_percent(percent : Vector2):
	return Vector2(viewport_size.x * (percent.x / 100.0), viewport_size.y * (percent.y / 100.0))

func fetch_group(group_name : Enums.Groups):
	var group_tscn = null
	match group_name:
		Enums.Groups.HORIZONTAL: group_tscn = NOTE_GROUP_HORIZONTAL
		Enums.Groups.VERTICAL: group_tscn = NOTE_GROUP_VERTICAL
		Enums.Groups.DIAG_UP: group_tscn = NOTE_GROUP_DIAG_UP
		Enums.Groups.DIAG_DOWN: group_tscn = NOTE_GROUP_DIAG_DOWN
		Enums.Groups.CURVE_UP: group_tscn = NOTE_GROUP_CURVE_UP
		Enums.Groups.CURVE_DOWN: group_tscn = NOTE_GROUP_CURVE_DOWN
	
	if group_tscn != null: return group_tscn
	else: print_debug("no grouping matching that name?!")

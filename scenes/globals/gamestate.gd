extends Node


# song vars 
var current_bpm := 125
var beat_length = 60 / current_bpm # seconds
var note_existence_length = 4 # beats - need to move this to an export of group vars
var group_existence_length = 4 # beats

# shifts the song to start further in, nice for testing tracks
var debug_start_time = 0.0 # seconds

# storing counts of interactions
var note_count := 0
var note_hit_count := 0

var perfect_count := 0
var good_count := 0
var okay_count := 0
var miss_count := 0

# 1. instantiate variables for a choosen song / level
# 2. track scoring and progress of a song
# 3. calculate results for display at the end of a song

func _ready():
	_establish_events()

func _establish_events():
	Events.group_finished.connect(_group_finished)
	Events.note_hit.connect(_note_hit)
	Events.note_spawned.connect(_note_spawned)

#### counting methods
func _note_hit(): note_hit_count += 1
func _note_spawned(): note_count += 1
func _group_finished(rating): # tracking group progress
	match rating:
		Enums.GroupRating.PERFECT : perfect_count += 1
		Enums.GroupRating.GOOD : good_count += 1
		Enums.GroupRating.OKAY : okay_count += 1
		Enums.GroupRating.MISS : perfect_count += 1

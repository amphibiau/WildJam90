extends Node

var current_bpm := 125
var beat_length = 60 / current_bpm # seconds
var note_existence_length = 4 # beats
var group_existence_length = 4 # beats

# shifts the song to start further in, nice for testing tracks
var debug_start_time = 0.0 # seconds

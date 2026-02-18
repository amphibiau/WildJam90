extends Node

###### for tracking values in the gamestate
signal note_spawned()
signal note_hit()
signal group_finished(rating : Enums.GroupRating) # also used by ui to show last group rating

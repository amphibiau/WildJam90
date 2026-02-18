extends AudioStreamPlayer2D

func _ready():
	self.play(Gamestate.debug_start_time)

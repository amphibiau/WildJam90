extends CanvasLayer

@onready var rating_label: Label = $Control/MarginContainer/rating_label
@onready var rating_animator: AnimationPlayer = $rating_animator

func _ready():
	Events.group_finished.connect(update_rating)

func update_rating(rating : Enums.GroupRating):
	rating_animator.play("RESET") 
	
	var rating_text : String
	match rating:
		Enums.GroupRating.MISS : rating_text = "miss!"
		Enums.GroupRating.OKAY : rating_text = "okay!"
		Enums.GroupRating.GOOD : rating_text = "good!"
		Enums.GroupRating.PERFECT : rating_text = "perfect!"
	
	rating_label.text = rating_text
	rating_animator.play("update_rating")

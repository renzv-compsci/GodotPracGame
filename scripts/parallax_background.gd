extends ParallaxBackground

#set up for semi parallax background 
var scrolling_speed = 100

func _process(delta):
	scroll_offset.x -= scrolling_speed * delta

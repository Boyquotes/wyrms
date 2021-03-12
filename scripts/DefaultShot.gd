extends KinematicBody2D

const speed = 1000

func _ready():
    pass # Replace with function body.
    
func _physics_process(delta):
    var velocity = Vector2(speed, 0).rotated(rotation)
    velocity = move_and_slide(velocity)


func explode():
    print("boom")
    queue_free()

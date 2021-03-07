extends KinematicBody2D

onready var tank_sprite:AnimatedSprite = $tank
onready var cannon:Sprite = $cannon
onready var charge_bar:TextureProgress = $cannon/chargeBar

var shot_charge = 0
var shot_increasing = true

const move_speed = 100

func _physics_process(delta):
    process_movement(delta)
    process_aim()
    process_fire()

func process_movement(delta):
    var direction = Vector2(0, 0)
    if Input.is_action_pressed("ui_up"):
        direction.y = -1
    if Input.is_action_pressed("ui_down"):
        direction.y = 1
    if Input.is_action_pressed("ui_left"):
        direction.x = -1
    if Input.is_action_pressed("ui_right"):
        direction.x = 1
    if direction.x or direction.y:
        tank_sprite.animation = resolve_sprite_direction(direction)
    
    move_and_slide(direction * move_speed) 
    
func resolve_sprite_direction(direction):
    if direction.y == 0 and direction.x != 0:
        return "horizontal"
    if direction.x == 0 and direction.y != 0:
        return "vertical"
    if direction.x == direction.y:
        return "main_diagonal"
    if direction.x != direction.y:
        return "anti_diagonal"
    
    
func process_aim():
    cannon.look_at(get_global_mouse_position())

func process_fire():
    if Input.is_mouse_button_pressed(BUTTON_LEFT):
        if(shot_increasing):
            shot_charge += 1
            shot_increasing = shot_charge <= 100
        else:
            shot_charge -= 1
            shot_increasing = shot_charge <= 0
    else:
        shot_charge = 0
        
    charge_bar.value = shot_charge

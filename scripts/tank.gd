extends KinematicBody2D

onready var tank_sprite:AnimatedSprite = $tank
onready var cannon:AnimatedSprite = $cannon
onready var charge_bar:TextureProgress = $progressBars/cannonBar
onready var health_bar:ProgressBar = $progressBars/healthBar

onready var bullet_container:Node2D = get_parent().get_node("bulletContainer")

onready var default_shot: PackedScene = load("res://scenes/bullets/DefaultShot.tscn")

var shot_charge = 0
var shot_increasing = true
var active = true

var health = 100

const move_speed = 100

func _ready():
    tank_sprite.modulate = Color(randf(), randf(), randf(), 1)


func _physics_process(delta):
    if(active):
        process_movement(delta)
        process_aim()
        process_fire()
        update_health()

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
        tank_sprite.frame = resolve_sprite_direction(direction)
    
    move_and_slide(direction * move_speed) 
    
func resolve_sprite_direction(direction: Vector2):
    var moving_angle = int(rad2deg(direction.angle())) % 360
    if moving_angle < 0:
        moving_angle += 360
    
    return moving_angle / 45
    
func process_aim():
    var cannon_angle = get_angle_to(get_global_mouse_position())

    cannon_angle = int(rad2deg(cannon_angle) + 45) % 360
    if cannon_angle < 0:
        cannon_angle += 360
    
    cannon.set_frame(int(cannon_angle / 45))    

func process_fire():
    if Input.is_mouse_button_pressed(BUTTON_LEFT):
        var bullet = default_shot.instance()
        bullet_container.add_child(bullet)
        bullet.position = self.position
        bullet.look_at(get_global_mouse_position())
        
        if(shot_increasing):
            shot_charge += 1
            shot_increasing = shot_charge <= 100
        else:
            shot_charge -= 1
            shot_increasing = shot_charge <= 0
    else:
        shot_charge = 0
    
    update_charge_bar()  

func update_charge_bar():
    charge_bar.value = shot_charge
    
func activate():
    active = true

func deactivate():
    active = false
    shot_charge = 0
    shot_increasing = true
    update_charge_bar()

func update_health():
    health_bar.value = health

extends CharacterBody3D

signal motion_updated(message)
signal weapon_selected(weapon, message)


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


var weapons := ["knife", "shotgun", "pistol", "nothing"]
var current_weapon :=  "knife"
var current_weapon_idx := 0

func _ready():
	add_to_group("actors")
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the isnput direction and handle the movement/deceleration.
	# As good practice, you hould replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)


	emit_signal("motion_updated", log_motion())

	move_and_slide()


func _unhandled_input(event):

	if event is InputEventMouseMotion:
		pass

	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_WHEEL_UP: current_weapon_idx += 1

		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN: current_weapon_idx -= 1

	
		current_weapon_idx = current_weapon_idx % 4
	
		print(log_weapon())


# use this to log when a given character moves in a space
func log_motion():
	
	return "x: %d, y: %d, z: %d" % [global_position.x, global_position.y, global_position.z]

#use this to log when weapons are being handled
func log_weapon():
	
	return "selected weapon: %s at %s" % [weapons[current_weapon_idx], log_motion()]

extends KinematicBody

const GRAVITY = 20
const SPEED = 100
const ROTATION = 10
var vel = Vector3()
var acceleration = 6
var vertical_vel = 0
var angular_acceleration = 10


func _ready():
	var direction = Vector3.BACK.rotated(Vector3.UP, $Camroot/h.global_transform.basis.get_euler().y)

func _physics_process(delta):
	var direction = Vector3()
	if Input.is_action_pressed("ui_up"):
		direction.z = -1
	if Input.is_action_pressed("ui_down"):
		direction.z = 1
	if Input.is_action_pressed("ui_left"):
		direction.x = -1
	if Input.is_action_pressed("ui_right"):
		direction.x = 1
	
	var h_rot = $Camroot/h.global_transform.basis.get_euler().y

	
	if direction:
		direction *= SPEED * delta
		direction = direction.rotated(Vector3.UP, h_rot).normalized()
		$MeshInstance.rotation.y = lerp_angle($MeshInstance.rotation.y, atan2(-direction.x, -direction.z), angular_acceleration*delta)
	
	else:
		$MeshInstance.rotation.y = lerp_angle($MeshInstance.rotation.y, $Camroot/h.rotation.y, delta * angular_acceleration)
		
	vel.x = direction.x
	vel.z = direction.z
	
	
	vel = lerp(vel, direction * SPEED, delta)
	move_and_slide(vel, Vector3.DOWN * vertical_vel)
	
	vertical_vel += GRAVITY * delta
	

	
	


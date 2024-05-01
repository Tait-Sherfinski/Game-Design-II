extends VehicleBody3D

const MAX_STEER = 0.4
const MAX_RPM = 300
const MAX_TORQUE = 200
const HORSE_POWER = 100

@onready var aud_player = $AudioStreamPlayer3D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func calc_engine_force(accel, rpm):
	return accel * MAX_TORQUE * (1 - rpm / MAX_RPM)

func _physics_process(delta):
	$Label2.text = "Lap: " + str(lap) + "/3"
	steering = lerp(steering, 
	Input.get_axis("ui_right", "ui_left") * MAX_STEER, 
	delta * 5)
	var accel = Input.get_axis("ui_down", "ui_up") * HORSE_POWER
	$backLeft.engine_force = calc_engine_force(accel, abs($backLeft.get_rpm()))
	$backRight.engine_force = calc_engine_force(accel, abs($backRight.get_rpm()))
	
	var fwd_mps = abs((self.linear_velocity * self.transform.basis).z)
	var mph = fwd_mps * 2.23694
	$Label.text = "%d mph" % mph
	
	$centerMass.global_position = $centerMass.global_position.lerp(
	self.global_position, delta * 20.0)
	$centerMass.transform = $centerMass.transform.interpolate_with(
	self.transform, delta * 5.0)
	$centerMass/Camera3D.look_at(self.global_position.lerp(
	self.global_position + self.linear_velocity, delta * 5.0))
	check_and_right_vehicle()
	
	if mph <= 5:
		aud_player.playing = false
	else:
		aud_player.playing = true
		aud_player.volume_db = mph - aud_player.volume_db
	


func check_and_right_vehicle():
	if self.global_transform.basis.y.dot(Vector3.UP) < 0:
		var current_rotation = self.rotation_degrees
		current_rotation.x = 0  # Reset pitch
		current_rotation.z = 0  # Reset roll
		self.rotation_degrees = current_rotation


var lap = 0

func _on_area_3d_body_entered(body):
	if body.is_in_group("racer"):
		lap += 1
	if lap > 3:
		$Label2.visible = false
		OS.alert("End Race")
		get_tree().change_scene_to_file("res://rc_world_3.tscn")


func _on_area_3d_2_body_entered(body):
	if body.is_in_group("racer"):
		lap += 1
	if lap > 3:
		$Label2.visible = false
		OS.alert("You Win!")
		get_tree().quit()


func _on_area_3d_3_body_entered(body):
	if body.is_in_group("racer"):
		lap += 1
	if lap > 3:
		$Label2.visible = false
		OS.alert("End Race")
		get_tree().change_scene_to_file("res://rc_world_2.tscn")

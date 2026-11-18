extends Area3D
class_name Cube
var taken := false
var scalefactor := 1.

var spinoff := Vector2(randf(), randf())
var coloff := Vector2(randf(), randf())

func _ready() -> void:
	$MeshInstance3D.rotation += Vector3.ONE * spinoff.x * TAU
	var material := StandardMaterial3D.new()
	material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	#$MeshInstance3D.mesh = $MeshInstance3D.mesh.duplicate()
	$MeshInstance3D.mesh.material = material

func _process(delta: float) -> void:
	$MeshInstance3D.rotation += Vector3.ONE * delta * (spinoff.y * 0.4 + 0.8)
	for ch in 3:
		$MeshInstance3D.mesh.material.albedo_color[ch] = clamp(abs(fmod(Time.get_ticks_msec() / 1000. * (0.1 + coloff.x * 0.2) + coloff.y + ch / 3., 1.) - 0.5) * 6 - 1, 0, 1)
	if not taken and overlaps_body(Global.player):
		taken = true
		Global.player.velocity = (Global.player.position - position).normalized() * 48
		Global.world.score += 1
	if taken:
		scalefactor = max(0, scalefactor - delta * 4)
	if scalefactor > 0:
		scale = Vector3.ONE * scalefactor
	else:
		visible = false

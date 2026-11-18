extends Area3D
class_name Cube
var taken := false
var scalefactor := 1.

var spinoff := Vector2(randf(), randf())

func _ready() -> void:
	$MeshInstance3D.rotation += Vector3.ONE * spinoff.x * TAU

func _process(delta: float) -> void:
	$MeshInstance3D.rotation += Vector3.ONE * delta * (spinoff.y * 0.4 + 0.8)
	for ch in 3:
		$MeshInstance3D.mesh.material.albedo_color[ch] = clamp(abs(fmod(Time.get_ticks_msec() / 1000. * 0.2 + ch / 3., 1.) - 0.5) * 6 - 1, 0, 1)
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

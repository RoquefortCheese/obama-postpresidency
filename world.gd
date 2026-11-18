extends Node
class_name World

const timelimit := 120.

var score := 0
var timeleft := timelimit
var finished := false

func generate():
	for iframe in 4:
		await get_tree().process_frame
	$Obama.visible = false
	$Terrain.generate()
	welcome()

func welcome():
	$Player.position = $Terrain.placerandom()
	var spin := randf() * TAU
	$Player/Camera3D.rotation.y = spin
	$Player.panning = Vector2(0, spin)

func _process(delta: float) -> void:
	timeleft -= delta
	$ScoreLabel.text = str(score)
	$TimeLabel.text = str(int(timeleft))
	if timeleft <= 0:
		finished = true
		$TimeLabel.text = "[R] to Restart"

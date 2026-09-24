class_name TransformComponent
extends RefCounted


var position: Vector3
var rotation: Vector3
var scale: Vector3


func _init(
	initial_position: Vector3 = Vector3.ZERO,
	initial_rotation: Vector3 = Vector3.ZERO,
	initial_scale: Vector3 = Vector3.ONE
) -> void:
	position = initial_position
	rotation = initial_rotation
	scale = initial_scale

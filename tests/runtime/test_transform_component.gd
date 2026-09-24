extends SceneTree


const TRANSFORM_COMPONENT_SCRIPT: Script = preload(
	"res://runtime/entity/components/transform.gd"
)


func _init() -> void:
	var transform: RefCounted = TRANSFORM_COMPONENT_SCRIPT.new()

	assert(
		transform.position == Vector3.ZERO,
		"Default position must be Vector3.ZERO."
	)

	assert(
		transform.rotation == Vector3.ZERO,
		"Default rotation must be Vector3.ZERO."
	)

	assert(
		transform.scale == Vector3.ONE,
		"Default scale must be Vector3.ONE."
	)

	var custom_transform: RefCounted = TRANSFORM_COMPONENT_SCRIPT.new(
		Vector3(10.0, 20.0, 30.0),
		Vector3(0.0, 90.0, 0.0),
		Vector3(2.0, 2.0, 2.0)
	)

	assert(
		custom_transform.position == Vector3(10.0, 20.0, 30.0),
		"Custom position must be stored correctly."
	)

	assert(
		custom_transform.rotation == Vector3(0.0, 90.0, 0.0),
		"Custom rotation must be stored correctly."
	)

	assert(
		custom_transform.scale == Vector3(2.0, 2.0, 2.0),
		"Custom scale must be stored correctly."
	)

	print("TransformComponent tests passed.")

	quit()

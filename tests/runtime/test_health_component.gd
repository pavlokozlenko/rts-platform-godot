extends SceneTree


const HEALTH_COMPONENT_SCRIPT: Script = preload(
	"res://runtime/entity/components/health.gd"
)


func _init() -> void:
	var health: RefCounted = HEALTH_COMPONENT_SCRIPT.new()

	assert(
		health.maximum == 100.0,
		"Default maximum health must be 100."
	)

	assert(
		health.current == 100.0,
		"Default current health must equal maximum health."
	)

	var custom_health: RefCounted = HEALTH_COMPONENT_SCRIPT.new(250.0)

	assert(
		custom_health.maximum == 250.0,
		"Custom maximum health must be stored correctly."
	)

	assert(
		custom_health.current == 250.0,
		"Custom current health must initially equal maximum health."
	)

	print("HealthComponent tests passed.")

	quit()

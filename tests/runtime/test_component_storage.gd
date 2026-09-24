extends SceneTree


const COMPONENT_STORAGE_SCRIPT: Script = preload(
	"res://runtime/entity/component_storage.gd"
)

const TRANSFORM_COMPONENT_SCRIPT: Script = preload(
	"res://runtime/entity/components/transform.gd"
)

const HEALTH_COMPONENT_SCRIPT: Script = preload(
	"res://runtime/entity/components/health.gd"
)


func _init() -> void:
	var storage: RefCounted = COMPONENT_STORAGE_SCRIPT.new()

	var entity_id := EntityId.new(10, 1)
	var same_entity_id := EntityId.new(10, 1)
	var different_entity_id := EntityId.new(10, 2)

	var transform: RefCounted = TRANSFORM_COMPONENT_SCRIPT.new(
		Vector3(10.0, 20.0, 30.0)
	)

	var health: RefCounted = HEALTH_COMPONENT_SCRIPT.new(250.0)

	assert(
		storage.add(entity_id, transform),
		"Adding a TransformComponent must succeed."
	)

	assert(
		storage.has(entity_id, TRANSFORM_COMPONENT_SCRIPT),
		"Storage must contain the TransformComponent."
	)

	assert(
		storage.has(same_entity_id, TRANSFORM_COMPONENT_SCRIPT),
		"Equivalent EntityIds must refer to the same component."
	)

	assert(
		not storage.has(
			different_entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		),
		"Different generations must refer to different entities."
	)

	var retrieved_transform: RefCounted = storage.get_component(
		entity_id,
		TRANSFORM_COMPONENT_SCRIPT
	)

	assert(
		retrieved_transform == transform,
		"get_component() must return the stored TransformComponent."
	)

	var duplicate_transform: RefCounted = (
		TRANSFORM_COMPONENT_SCRIPT.new()
	)

	assert(
		storage.add(entity_id, duplicate_transform) == false,
		"Adding the same component type twice must fail."
	)

	assert(
		storage.add(entity_id, health),
		"An entity must be able to have a HealthComponent."
	)

	assert(
		storage.has(entity_id, HEALTH_COMPONENT_SCRIPT),
		"Storage must contain the HealthComponent."
	)

	var retrieved_health: RefCounted = storage.get_component(
		entity_id,
		HEALTH_COMPONENT_SCRIPT
	)

	assert(
		retrieved_health == health,
		"get_component() must return the stored HealthComponent."
	)

	assert(
		retrieved_health.maximum == 250.0,
		"Stored HealthComponent maximum must be preserved."
	)

	assert(
		storage.remove(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Removing HealthComponent must succeed."
	)

	assert(
		not storage.has(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Removed HealthComponent must no longer exist."
	)

	assert(
		storage.has(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		),
		"Removing one component must not remove other components."
	)

	assert(
		storage.remove_all(entity_id),
		"Removing all components must succeed."
	)

	assert(
		not storage.has(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		),
		"All components must be removed."
	)

	assert(
		not storage.has(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"All components must be removed."
	)

	assert(
		storage.add(
			EntityId.invalid(),
			TRANSFORM_COMPONENT_SCRIPT.new()
		) == false,
		"Invalid EntityIds must not be accepted."
	)

	assert(
		storage.add(entity_id, null) == false,
		"Null components must not be accepted."
	)

	print("ComponentStorage tests passed.")

	quit()

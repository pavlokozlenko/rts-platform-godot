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

	var transform_entities: Array[Vector2i] = (
		storage.get_entities_with(
			TRANSFORM_COMPONENT_SCRIPT
		)
	)

	assert(
		transform_entities.size() == 1,
		"Exactly one entity must have a TransformComponent."
	)

	assert(
		transform_entities[0] == entity_id.to_key(),
		"Query must return the correct entity key."
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

	var health_entities: Array[Vector2i] = (
		storage.get_entities_with(
			HEALTH_COMPONENT_SCRIPT
		)
	)

	assert(
		health_entities.size() == 1,
		"Exactly one entity must have a HealthComponent."
	)

	assert(
		health_entities[0] == entity_id.to_key(),
		"Health query must return the correct entity key."
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

	var health_entities_after_remove: Array[Vector2i] = (
		storage.get_entities_with(
			HEALTH_COMPONENT_SCRIPT
		)
	)

	assert(
		health_entities_after_remove.is_empty(),
		"Removed HealthComponent must no longer appear in queries."
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

	var transform_entities_after_remove: Array[Vector2i] = (
		storage.get_entities_with(
			TRANSFORM_COMPONENT_SCRIPT
		)
	)

	assert(
		transform_entities_after_remove.is_empty(),
		"Removed entity must no longer appear in queries."
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

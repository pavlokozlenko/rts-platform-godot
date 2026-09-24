extends SceneTree


const ENTITY_MANAGER_SCRIPT: Script = preload(
	"res://runtime/entity/entity_manager.gd"
)

const COMPONENT_STORAGE_SCRIPT: Script = preload(
	"res://runtime/entity/component_storage.gd"
)

const TRANSFORM_COMPONENT_SCRIPT: Script = preload(
	"res://runtime/entity/components/transform.gd"
)


func _init() -> void:
	var entity_manager: RefCounted = ENTITY_MANAGER_SCRIPT.new()
	var transform_storage: RefCounted = COMPONENT_STORAGE_SCRIPT.new()

	var entity_id: EntityId = entity_manager.create_entity()

	assert(
		entity_manager.is_alive(entity_id),
		"Created entity must be alive."
	)

	var transform: RefCounted = TRANSFORM_COMPONENT_SCRIPT.new(
		Vector3(10.0, 20.0, 30.0),
		Vector3(0.0, 90.0, 0.0),
		Vector3(2.0, 2.0, 2.0)
	)

	assert(
		transform_storage.add(entity_id, transform),
		"Adding TransformComponent must succeed."
	)

	assert(
		transform_storage.has(entity_id),
		"Transform storage must contain the entity."
	)

	var retrieved_transform: RefCounted = (
		transform_storage.get_component(entity_id)
	)

	assert(
		retrieved_transform == transform,
		"Storage must return the same TransformComponent."
	)

	assert(
		retrieved_transform.position == Vector3(10.0, 20.0, 30.0),
		"Stored Transform position must be preserved."
	)

	assert(
		retrieved_transform.rotation == Vector3(0.0, 90.0, 0.0),
		"Stored Transform rotation must be preserved."
	)

	assert(
		retrieved_transform.scale == Vector3(2.0, 2.0, 2.0),
		"Stored Transform scale must be preserved."
	)

	assert(
		transform_storage.remove(entity_id),
		"Removing the TransformComponent must succeed."
	)

	assert(
		not transform_storage.has(entity_id),
		"Entity must no longer have a TransformComponent."
	)

	assert(
		transform_storage.get_component(entity_id) == null,
		"Removed TransformComponent must no longer be retrievable."
	)

	assert(
		entity_manager.destroy_entity(entity_id),
		"Destroying the entity must succeed."
	)

	assert(
		not entity_manager.is_alive(entity_id),
		"Destroyed entity must no longer be alive."
	)

	print("Entity Transform integration tests passed.")

	quit()

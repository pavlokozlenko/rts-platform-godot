extends SceneTree


const ENTITY_WORLD_SCRIPT: Script = preload(
	"res://runtime/entity/entity_world.gd"
)

const TRANSFORM_COMPONENT_SCRIPT: Script = preload(
	"res://runtime/entity/components/transform.gd"
)

const HEALTH_COMPONENT_SCRIPT: Script = preload(
	"res://runtime/entity/components/health.gd"
)


func _init() -> void:
	var world: RefCounted = ENTITY_WORLD_SCRIPT.new()

	var entity_id: EntityId = world.create_entity()

	var transform: RefCounted = TRANSFORM_COMPONENT_SCRIPT.new(
		Vector3(10.0, 20.0, 30.0),
		Vector3(0.0, 90.0, 0.0),
		Vector3.ONE
	)

	var health: RefCounted = HEALTH_COMPONENT_SCRIPT.new(250.0)

	assert(
		world.component_storage.add(entity_id, transform),
		"Adding TransformComponent must succeed."
	)

	assert(
		world.component_storage.add(entity_id, health),
		"Adding HealthComponent must succeed."
	)

	assert(
		world.component_storage.has(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		),
		"Entity must have a TransformComponent."
	)

	assert(
		world.component_storage.has(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Entity must have a HealthComponent."
	)

	var retrieved_transform: RefCounted = (
		world.component_storage.get_component(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		)
	)

	assert(
		retrieved_transform == transform,
		"Stored TransformComponent must be retrievable."
	)

	assert(
		retrieved_transform.position == Vector3(10.0, 20.0, 30.0),
		"Transform position must be preserved."
	)

	assert(
		retrieved_transform.rotation == Vector3(0.0, 90.0, 0.0),
		"Transform rotation must be preserved."
	)

	assert(
		retrieved_transform.scale == Vector3.ONE,
		"Transform scale must be preserved."
	)

	var retrieved_health: RefCounted = (
		world.component_storage.get_component(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		)
	)

	assert(
		retrieved_health == health,
		"Stored HealthComponent must be retrievable."
	)

	assert(
		retrieved_health.current == 250.0,
		"Health current value must be preserved."
	)

	assert(
		retrieved_health.maximum == 250.0,
		"Health maximum value must be preserved."
	)

	assert(
		world.destroy_entity(entity_id),
		"Destroying the entity must succeed."
	)

	assert(
		not world.component_storage.has(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		),
		"TransformComponent must be removed with the entity."
	)

	assert(
		not world.component_storage.has(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"HealthComponent must be removed with the entity."
	)

	print("Entity components tests passed.")

	quit()

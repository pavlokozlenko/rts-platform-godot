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

	assert(
		world.is_alive(entity_id),
		"Created entity must be alive."
	)

	var transform: RefCounted = TRANSFORM_COMPONENT_SCRIPT.new(
		Vector3(100.0, 200.0, 300.0),
		Vector3(0.0, 45.0, 0.0),
		Vector3.ONE
	)

	var health: RefCounted = HEALTH_COMPONENT_SCRIPT.new(500.0)

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
		"Entity must contain its TransformComponent."
	)

	assert(
		world.component_storage.has(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Entity must contain its HealthComponent."
	)

	assert(
		world.destroy_entity(entity_id),
		"Destroying an alive entity must succeed."
	)

	assert(
		not world.is_alive(entity_id),
		"Destroyed entity must no longer be alive."
	)

	assert(
		not world.component_storage.has(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		),
		"Destroying an entity must remove its TransformComponent."
	)

	assert(
		not world.component_storage.has(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Destroying an entity must remove its HealthComponent."
	)

	assert(
		world.component_storage.get_component(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		) == null,
		"Destroyed entity's TransformComponent must no longer be retrievable."
	)

	assert(
		world.component_storage.get_component(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		) == null,
		"Destroyed entity's HealthComponent must no longer be retrievable."
	)

	assert(
		world.destroy_entity(entity_id) == false,
		"Destroying an already destroyed entity must fail."
	)

	print("EntityWorld tests passed.")

	quit()

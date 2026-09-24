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
		world.add_component(entity_id, transform),
		"Adding TransformComponent through EntityWorld must succeed."
	)

	assert(
		world.add_component(entity_id, health),
		"Adding HealthComponent through EntityWorld must succeed."
	)

	var retrieved_transform: RefCounted = world.get_component(
		entity_id,
		TRANSFORM_COMPONENT_SCRIPT
	)

	assert(
		retrieved_transform == transform,
		"EntityWorld must return the stored TransformComponent."
	)

	var retrieved_health: RefCounted = world.get_component(
		entity_id,
		HEALTH_COMPONENT_SCRIPT
	)

	assert(
		retrieved_health == health,
		"EntityWorld must return the stored HealthComponent."
	)

	assert(
		world.remove_component(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Removing HealthComponent through EntityWorld must succeed."
	)

	assert(
		world.get_component(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		) == null,
		"Removed HealthComponent must no longer be accessible."
	)

	assert(
		world.get_component(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		) == transform,
		"Removing HealthComponent must not remove TransformComponent."
	)

	assert(
		world.remove_component(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		) == false,
		"Removing an already removed component must fail."
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
		world.get_component(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		) == null,
		"Destroyed entity's TransformComponent must no longer be accessible."
	)

	assert(
		world.remove_component(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		) == false,
		"Removing a component from a destroyed entity must fail."
	)

	assert(
		world.destroy_entity(entity_id) == false,
		"Destroying an already destroyed entity must fail."
	)

	print("EntityWorld tests passed.")

	quit()

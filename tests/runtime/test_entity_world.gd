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

	var first_entity: EntityId = world.create_entity()
	var second_entity: EntityId = world.create_entity()

	assert(
		world.is_alive(first_entity),
		"First created entity must be alive."
	)

	assert(
		world.is_alive(second_entity),
		"Second created entity must be alive."
	)

	var first_transform: RefCounted = (
		TRANSFORM_COMPONENT_SCRIPT.new(
			Vector3(100.0, 200.0, 300.0),
			Vector3(0.0, 45.0, 0.0),
			Vector3.ONE
		)
	)

	var first_health: RefCounted = (
		HEALTH_COMPONENT_SCRIPT.new(500.0)
	)

	var second_transform: RefCounted = (
		TRANSFORM_COMPONENT_SCRIPT.new(
			Vector3(400.0, 500.0, 600.0),
			Vector3.ZERO,
			Vector3.ONE
		)
	)

	assert(
		world.add_component(first_entity, first_transform),
		"Adding first TransformComponent must succeed."
	)

	assert(
		world.add_component(first_entity, first_health),
		"Adding first HealthComponent must succeed."
	)

	assert(
		world.add_component(second_entity, second_transform),
		"Adding second TransformComponent must succeed."
	)

	var transform_entities: Array[EntityId] = (
		world.get_entities_with(
			TRANSFORM_COMPONENT_SCRIPT
		)
	)

	assert(
		transform_entities.size() == 2,
		"Query must return both entities with TransformComponent."
	)

	assert(
		_contains_entity(
			transform_entities,
			first_entity
		),
		"Query must contain the first entity."
	)

	assert(
		_contains_entity(
			transform_entities,
			second_entity
		),
		"Query must contain the second entity."
	)

	var health_entities: Array[EntityId] = (
		world.get_entities_with(
			HEALTH_COMPONENT_SCRIPT
		)
	)

	assert(
		health_entities.size() == 1,
		"Query must return only the entity with HealthComponent."
	)

	assert(
		_contains_entity(
			health_entities,
			first_entity
		),
		"Health query must contain the first entity."
	)

	assert(
		not _contains_entity(
			health_entities,
			second_entity
		),
		"Health query must not contain the second entity."
	)

	assert(
		world.remove_component(
			first_entity,
			HEALTH_COMPONENT_SCRIPT
		),
		"Removing HealthComponent must succeed."
	)

	health_entities = world.get_entities_with(
		HEALTH_COMPONENT_SCRIPT
	)

	assert(
		health_entities.is_empty(),
		"Removed HealthComponent must disappear from queries."
	)

	assert(
		world.destroy_entity(first_entity),
		"Destroying the first entity must succeed."
	)

	transform_entities = world.get_entities_with(
		TRANSFORM_COMPONENT_SCRIPT
	)

	assert(
		transform_entities.size() == 1,
		"Destroyed entity must disappear from component queries."
	)

	assert(
		_contains_entity(
			transform_entities,
			second_entity
		),
		"Second entity must remain in the TransformComponent query."
	)

	assert(
		not _contains_entity(
			transform_entities,
			first_entity
		),
		"Destroyed entity must not remain in the TransformComponent query."
	)

	print("EntityWorld tests passed.")

	quit()


func _contains_entity(
	entities: Array[EntityId],
	target: EntityId
) -> bool:
	for entity_id in entities:
		if entity_id.equals(target):
			return true

	return false

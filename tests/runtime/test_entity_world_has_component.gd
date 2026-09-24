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
		not world.has_component(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Entity must not have HealthComponent before it is added."
	)

	var health: RefCounted = (
		HEALTH_COMPONENT_SCRIPT.new(100.0)
	)

	assert(
		world.add_component(
			entity_id,
			health
		),
		"Adding HealthComponent must succeed."
	)

	assert(
		world.has_component(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Entity must have HealthComponent after it is added."
	)

	assert(
		not world.has_component(
			entity_id,
			TRANSFORM_COMPONENT_SCRIPT
		),
		"Entity must not report a TransformComponent that was not added."
	)

	assert(
		world.remove_component(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Removing HealthComponent must succeed."
	)

	assert(
		not world.has_component(
			entity_id,
			HEALTH_COMPONENT_SCRIPT
		),
		"Entity must not have HealthComponent after it is removed."
	)

	print("EntityWorld has_component tests passed.")

	quit()

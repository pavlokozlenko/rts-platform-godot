extends SceneTree

const ENTITY_WORLD_SCRIPT: Script = preload(
	"res://runtime/entity/entity_world.gd"
)

const HEALTH_COMPONENT_SCRIPT: Script = preload(
	"res://runtime/entity/components/health.gd"
)


func _init() -> void:
	var world: RefCounted = ENTITY_WORLD_SCRIPT.new()

	var entity_id: EntityId = world.create_entity()

	var original_health: RefCounted = (
		HEALTH_COMPONENT_SCRIPT.new(100.0)
	)

	assert(
		world.add_component(
			entity_id,
			original_health
		),
		"Adding the original HealthComponent must succeed."
	)

	var replacement_health: RefCounted = (
		HEALTH_COMPONENT_SCRIPT.new(500.0)
	)

	assert(
		world.replace_component(
			entity_id,
			replacement_health
		),
		"Replacing an existing component must succeed."
	)

	var current_health: RefCounted = world.get_component(
		entity_id,
		HEALTH_COMPONENT_SCRIPT
	)

	assert(
		current_health == replacement_health,
		"EntityWorld must return the replacement component."
	)

	assert(
		current_health != original_health,
		"EntityWorld must no longer return the original component."
	)

	assert(
		current_health.maximum == 500.0,
		"Replacement component data must be preserved."
	)

	assert(
		world.get_entities_with(
			HEALTH_COMPONENT_SCRIPT
		).size() == 1,
		"Replacing a component must not duplicate the entity in queries."
	)

	print("Entity component replacement tests passed.")

	quit()

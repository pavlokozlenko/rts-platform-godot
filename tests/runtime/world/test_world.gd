extends SceneTree


const WORLD_SCRIPT: Script = preload(
	"res://runtime/world/world.gd"
)


func _init() -> void:
	var world: RefCounted = WORLD_SCRIPT.new()

	assert(
		world.entity_world != null,
		"World must create an EntityWorld."
	)

	var entity_id: EntityId = world.entity_world.create_entity()

	assert(
		world.entity_world.is_alive(entity_id),
		"World's EntityWorld must be able to create entities."
	)

	print("World tests passed.")

	quit()

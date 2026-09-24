extends SceneTree


const COMPONENT_STORAGE_SCRIPT: Script = preload(
	"res://runtime/entity/component_storage.gd"
)


class TestComponent:
	extends RefCounted

	var value: int

	func _init(component_value: int) -> void:
		value = component_value


func _init() -> void:
	var storage: RefCounted = COMPONENT_STORAGE_SCRIPT.new()

	var entity_id := EntityId.new(10, 1)
	var same_entity_id := EntityId.new(10, 1)
	var different_entity_id := EntityId.new(10, 2)

	var component := TestComponent.new(123)

	assert(
		storage.add(entity_id, component),
		"Adding a component to an empty storage must succeed."
	)

	assert(
		storage.has(entity_id),
		"Storage must contain a component after adding it."
	)

	assert(
		storage.has(same_entity_id),
		"Equivalent EntityIds must refer to the same component."
	)

	assert(
		not storage.has(different_entity_id),
		"Different generations must refer to different entities."
	)

	var retrieved_component: RefCounted = storage.get_component(entity_id)

	assert(
		retrieved_component == component,
		"get_component() must return the stored component."
	)

	assert(
		storage.add(entity_id, TestComponent.new(456)) == false,
		"Adding a second component to the same storage slot must fail."
	)

	assert(
		storage.remove(entity_id),
		"Removing an existing component must succeed."
	)

	assert(
		not storage.has(entity_id),
		"Storage must not contain the component after removal."
	)

	assert(
		storage.get_component(entity_id) == null,
		"get_component() must return null after removal."
	)

	assert(
		storage.remove(entity_id) == false,
		"Removing a component that does not exist must fail."
	)

	assert(
		storage.add(EntityId.invalid(), TestComponent.new(789)) == false,
		"Invalid EntityIds must not be accepted."
	)

	assert(
		storage.add(entity_id, null) == false,
		"Null components must not be accepted."
	)

	print("ComponentStorage tests passed.")

	quit()

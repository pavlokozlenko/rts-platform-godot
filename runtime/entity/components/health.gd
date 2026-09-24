class_name HealthComponent
extends RefCounted


var current: float
var maximum: float


func _init(initial_maximum: float = 100.0) -> void:
    maximum = initial_maximum
    current = maximum

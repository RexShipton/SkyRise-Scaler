extends Node2D

signal is_crushed

@onready var top: Area2D = $Top
@onready var bottom: Area2D = $Bottom
@onready var crush_area: Area2D = $CrushArea


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.new_item


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#if top.has_overlapping_bodies() and bottom.has_overlapping_bodies():
		#is_crushed.emit()
	if crush_area.has_overlapping_bodies():
		is_crushed.emit()

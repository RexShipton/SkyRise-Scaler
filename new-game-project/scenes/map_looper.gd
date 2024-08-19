extends Node2D

@onready var tile_map_layer_1: TileMapLayer = $TileMapLayer1
@onready var tile_map_layer_2: TileMapLayer = $TileMapLayer2
@onready var tile_map_layer_3: TileMapLayer = $TileMapLayer3
@onready var tile_map_layer_base: TileMapLayer = $TileMapLayerBase

var tileMaps : Array
var tileHeight : float = 640
var tileMapIndex : int = 0

var totalDistanceDropped : float = 0

var mapDropSpeed : float = 10
var speedIncreasePerSecond : float = .1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	tileMaps.append(tile_map_layer_1)
	tileMaps.append(tile_map_layer_2)
	tileMaps.append(tile_map_layer_3)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	totalDistanceDropped += mapDropSpeed * delta
	
	if tile_map_layer_base.visible:
		tile_map_layer_base.global_position.y += mapDropSpeed * delta
		if tile_map_layer_base.global_position.y > 1000:
			tile_map_layer_base.visible = false
	
	var tileToMove : int = -1
	var highestTileHeight : float = 0
	
	for i in tileMaps:
		i.global_position.y += mapDropSpeed * delta
		if i.global_position.y < highestTileHeight:
			highestTileHeight = i.global_position.y
		if i.global_position.y >= 1000:
			tileToMove = tileMaps.find(i)
	
	if tileToMove >= 0:
		tileMaps[tileToMove].global_position.y = highestTileHeight - tileHeight
	
	mapDropSpeed += speedIncreasePerSecond * delta

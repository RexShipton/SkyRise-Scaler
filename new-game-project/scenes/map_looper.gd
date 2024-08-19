extends Node2D

@onready var tile_map_layer_1: TileMapLayer = $TileMapLayer1
@onready var tile_map_layer_2: TileMapLayer = $TileMapLayer2
@onready var tile_map_layer_3: TileMapLayer = $TileMapLayer3
@onready var tile_map_layer_base: TileMapLayer = $TileMapLayerBase

var tileMaps : Array
var tileHeight : float = 640
var tileMapIndex : int = 0

var connectedPieces : Array

var active : bool = false
var gameOver : bool = false
var totalDistanceDropped : float = 0

## Distance per second the whole map shifts down.
@export var mapDropSpeed : float = 10
## Distance per second the Map Drop Speed increases.
@export var speedIncreasePerSecond : float = .1

func _ready() -> void:
	tileMaps.append(tile_map_layer_1)
	tileMaps.append(tile_map_layer_2)
	tileMaps.append(tile_map_layer_3)

func _process(delta: float) -> void:
	if !active: return
	
	var dropSpeed : float = mapDropSpeed * delta
	
	totalDistanceDropped += dropSpeed
	
	if tile_map_layer_base.visible:
		tile_map_layer_base.global_position.y += dropSpeed
		if tile_map_layer_base.global_position.y > 1000:
			tile_map_layer_base.visible = false
	
	var piecesToDelete : Array
	
	for i in connectedPieces:
		i.global_position.y += dropSpeed
		if i.global_position.y >= 1000:
			piecesToDelete.append(i)
	
	for i in piecesToDelete:
		connectedPieces.erase(i)
		i.queue_free()
	
	var tileToMove : int = -1
	var highestTileHeight : float = 0
	
	for i in tileMaps:
		i.global_position.y += dropSpeed
		if i.global_position.y < highestTileHeight:
			highestTileHeight = i.global_position.y
		if i.global_position.y >= 1000:
			tileToMove = tileMaps.find(i)
	
	if tileToMove >= 0:
		tileMaps[tileToMove].global_position.y = highestTileHeight - tileHeight
	
	mapDropSpeed += speedIncreasePerSecond * delta

func add_piece(piece : Node) -> void:
	connectedPieces.append(piece)
	if !active:
		activate()

func activate() -> void:
	if gameOver: return
	
	active = true

func deActivate() -> void:
	gameOver = true
	active = false

func _on_score_updater_timeout() -> void:
	ScoreManager.scoreResource.change_score(totalDistanceDropped)

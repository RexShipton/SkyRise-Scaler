extends Node2D

@onready var tile_map_layer_1: TileMapLayer = $ForegroundTilemapHolder/TileMapLayer1
@onready var tile_map_layer_2: TileMapLayer = $ForegroundTilemapHolder/TileMapLayer2
@onready var tile_map_layer_3: TileMapLayer = $ForegroundTilemapHolder/TileMapLayer3
@onready var tile_map_layer_base: TileMapLayer = $ForegroundTilemapHolder/TileMapLayerBase
@onready var bg_tile_map_layer_1: TileMapLayer = $BackgroundTilemapHolder/BGTileMapLayer1
@onready var bg_tile_map_layer_2: TileMapLayer = $BackgroundTilemapHolder/BGTileMapLayer2

@onready var score_updater: Timer = $ScoreUpdater

signal updateLevel

var tileMaps : Array
var tileHeight : float = 640
var tileMapIndex : int = 0

var bgTileMaps : Array
var bgTileHeight : float = 1408
var bgTileMapIndex : int = 0
var bgTileSpeedMultiplier : float = .25

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
	bgTileMaps.append(bg_tile_map_layer_1)
	bgTileMaps.append(bg_tile_map_layer_2)

func _process(delta: float) -> void:
	if !active: return
	
	
	var dropSpeed : float = mapDropSpeed * delta
	dropSpeed = clampf(dropSpeed, 0, 600)
	
	if !gameOver:
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
	
	tileToMove = -1
	highestTileHeight = 0
	
	for i in bgTileMaps:
		i.global_position.y += dropSpeed * bgTileSpeedMultiplier
		if i.global_position.y < highestTileHeight:
			highestTileHeight = i.global_position.y
		if i.global_position.y >= 1000:
			tileToMove = bgTileMaps.find(i)
	
	if tileToMove >= 0:
		bgTileMaps[tileToMove].global_position.y = highestTileHeight - bgTileHeight
	
	#if !gameOver:
		#mapDropSpeed += speedIncreasePerSecond * delta

func add_piece(piece : Node) -> void:
	connectedPieces.append(piece)
	if !active:
		activate()

func activate() -> void:
	if gameOver: return
	
	active = true

func deActivate() -> void:
	score_updater.stop()
	gameOver = true
	
	if ScoreManager.stopMapOnGameOver:
		active = false

func _on_score_updater_timeout() -> void:
	
	ScoreManager.scoreResource.change_score(totalDistanceDropped)
	var score = ScoreManager.scoreResource.score
	var multiple_past_2k = 1
	if score > 49 and score < 100:
		mapDropSpeed = 15
		updateLevel.emit(2)
	if score > 99 and score < 200:
		mapDropSpeed = 20
		updateLevel.emit(3)
	if score > 199 and score < 300:
		mapDropSpeed = 25
		updateLevel.emit(4)
	if score > 299 and score < 500:
		mapDropSpeed = 30
		updateLevel.emit(5)
	if score > 499 and score < 750:
		mapDropSpeed = 35
		updateLevel.emit(6)
	if score > 749 and score < 1000:
		mapDropSpeed = 40
		updateLevel.emit(7)
	if score > 999 and score < 1250:
		mapDropSpeed = 45
		updateLevel.emit(8)
	if score > 1249 and score < 1500:
		mapDropSpeed = 50
		updateLevel.emit(9)
	if score > 1499 and score < 2000:
		mapDropSpeed = 55
		updateLevel.emit(10)
	if score > 2000:
		if score > (2000 + (500 * multiple_past_2k)):
			multiple_past_2k += 1
			updateLevel.emit(5 + multiple_past_2k)
	ScoreManager.scoreResource.change_map_speed(mapDropSpeed)

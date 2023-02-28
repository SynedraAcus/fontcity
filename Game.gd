extends Node

# All valid tile types
const tile_names = [
	'empty', 'man_basic', 'man_janitor', 'man_intel', 'school',
	'shovel', 'mop', 'books', 'man_worker', 'factory', #9
	'hammer', 'dustpan', 'laptop', 'closed',
	'jacket', 'washed', 'tubes', 'copier',
	'wrench', 'money', 'microscope', 'house']

var map = []
var xsize = 6
var ysize = 5

var valid_items = [] # All tiles that can be spawned on a given point in time

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	valid_items = [1, 5, 6, 7, 10, 11, 12, 14, 15, 16, 18, 20]
	# Generate a map
	generate_new_map()
	
func generate_new_map():
	map.clear()
	$TileMap.clear()
	for row in range(ysize):
		var l = []
		for column in range(xsize):
			# Fill with empties
			l.append(0)
			$TileMap.set_cell(column, row, 0)
		map.append(l)
	# Make sure there is at least one human available from turn 1
	var xpos = randi() % xsize
	var ypos = randi() % ysize
	add_item(xpos, ypos, 1)
	# Otherwise just drop stuff randomly
	for _j in range(3):
		add_random_item()
	
func add_item(x, y, item):
	map[y][x] = item
	$TileMap.set_cell(x, y, item)
	
func add_random_item():
	var found = false
	var xpos
	var ypos
	while !found:
		# Hit randomly until we find an empty spot
		xpos = randi() % xsize
		ypos = randi() % ysize
		if map[ypos][xpos] == 0:
			found = true
	var item = valid_items[randi() % len(valid_items)]
	add_item(xpos, ypos, item)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

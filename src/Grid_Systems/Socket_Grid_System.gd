class_name Socket_Grid_System
extends TileMap

#the tile size of the grid
var _tile_Size : Vector2 setget set_Tile_Size

#the half of the tile size to center it 
var _half_Tile_Size : Vector2

#the grid size
var _grid_Size :Vector2

#where the grid start on the map
var _grid_Start:Vector2

#the offset needed to allign the grid with the background
var _offset : Vector2

#helps create the grid
var _grid : Array

#helps getting the position of the anterior created grid
var _positions : Array

#the constructor
func create_Instance():

	#set up the tiles offset/size and grid start pos/size
	set_Tile_Size(Globals.cell_Size)
	set_Grid_Size(Globals.grid_size["Oxigen_Room"])
	set_Grid_Start(Globals.grid_Start_Pos["Oxigen_Room"])
	set_Tile_Offset(Globals.tile_offset["Oxigen_Room"])

	#create grid and colliders
	create_Grid()
	create_Collider()

#setter for the half/tile set
func set_Tile_Size(tile_Size : Vector2):
	set("cell_size",tile_Size)
	_half_Tile_Size = tile_Size / 2

#setter for the grid size depending on the room
func set_Grid_Size(room : Vector2):
	_grid_Size = room

#setter for the grid starting position depending on the room
func set_Grid_Start(room : Vector2):
	_grid_Start = room

#setter for the offset of the cell center determination depending on the room
func set_Tile_Offset(offset : Vector2):
	_offset = offset

#creates the grid and save its positions in the positions array
func create_Grid():
	
	#create a array of arrays for x and y is null mimic a multidimensional array
	for x in range(_grid_Start.x + _grid_Size.x):
		_grid.append([])
		for y in range(_grid_Start.y + _grid_Size.y):
			
			#check if the cell location in the grid is the one needed to put the future area2D
			if(y>=_grid_Start.y && x >= _grid_Start.x ):
				_grid[x].append(0)
				
				#take the cell position the use it as a waypoint where to put the area2D
				var grid_Pos = Vector2(x,y)
				_positions.append(grid_Pos)
				
				#copy the cell position and grid values
				Globals.cell_Position["Oxigen_Room"].append(grid_Pos)

#creates a area2D for future collisions checks
func create_Collider():
	var i = 1
	
	for pos in _positions:
		
		#creates a area2D node add pos it on center of the tile
		var area = Area2D.new()
		
		#sets the name of the cell 
		area.set_name("Cell_" + str(i))
		i=i+1
		
		#select the objects that will collide with the area
		area.set_collision_mask_bit(0,false)
		area.set_collision_mask_bit(1,true)
		
		#position the area relative to the screen and add the children
		area.set_position(map_to_world(pos) +_offset - _half_Tile_Size) 
		add_child(area)
		
		#create a circlrhape2D to be added to the collision shape
		var shape = CircleShape2D.new()
		shape.set_radius(10)
		
		#create a collisionshape2D to be added to the area
		var collision = CollisionShape2D.new()
		collision.set_shape(shape)
		area.add_child(collision)


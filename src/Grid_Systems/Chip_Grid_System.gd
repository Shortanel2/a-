class_name Chip_Grid_System
extends Area2D

var _grid_Size : Vector2

var _grid_Status : Array

#setter for the grid size depending on the room
func set_Grid_Size(room : Vector2):
	_grid_Size = room

#create an multidimensional array which will help see if they are chips on grid 
func create_Grid():
	for x in range(_grid_Size.x):
		_grid_Status.append([])
		for y in range(_grid_Size.y):
			_grid_Status[x].append(0)


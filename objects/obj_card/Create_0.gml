/// @description Insert description here
// You can write your code in this editor

_throw = irandom_range(0,2)
flipped = true

moving = false
moveStep = 0
moveSpd = 0.1
moveStart = {_x: x,_y: y}
moveEnd = {_x: x,_y: y}

handPos = 0

function Move(x2,y2){
	if !moving{
		//depth = -obj_manager.discardStep
		moveEnd = {_x: x2,_y: y2}
		moving = true
	}
}

function Reroll(){
	_throw = irandom_range(0,2)
}
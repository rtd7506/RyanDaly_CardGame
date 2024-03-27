/// @description Insert description here
// You can write your code in this editor

if moving{
	moveStep += moveSpd
	x = lerp(moveStart._x,moveEnd._x,moveStep)
	y = lerp(moveStart._y,moveEnd._y,moveStep)
	if moveStep >= 1{
		moveStart._x = moveEnd._x
		moveStart._y = moveEnd._y
		moveStep = 0
		moving = false
	}
}

if obj_manager.picking && array_contains(obj_manager.playerHand,id){
	if place_meeting(x,y,obj_cursor){
		y = obj_markPlayHand.y-8
		if mouse_check_button_pressed(mb_left){
			obj_manager.Chosen(handPos)
		}
	}else{
		y = obj_markPlayHand.y
	}
}



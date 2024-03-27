/// @description Insert description here
// You can write your code in this editor

if dealing{
	if !dealCard.moving{
		if dealStep < 5{
			dealStep+=1
			dealCard = array_pop(startDeck)
			if (dealStep % 2 == 0){
				array_push(playerHand,dealCard)
				dealCard.Move(obj_markPlayHand.x-80+floor(dealStep/2)*80,obj_markPlayHand.y)
				dealCard.handPos = floor(dealStep/2)
			}else{
				array_push(enemyHand,dealCard)
				dealCard.Move(obj_markEnHand.x-80+floor(dealStep/2)*80,obj_markEnHand.y)
				dealCard.handPos = floor(dealStep/2)
			}
		}else{
			dealing = false
			picking = true
			for (var i=0;i<array_length(playerHand);i++){
				playerHand[i].flipped = false
			}
			EnChoose(irandom_range(0,2))
		}
	}
}

if playing{
	if !playCard.moving{
		playing = false
		battling = true
		Battle()
	}
}

if battling{
	//enemyField[0].flipped = false
}

if discarding{
	if !discardCard.moving{
		discardStep += 1
		if array_length(enemyField) > 0{
			discardCard = array_pop(enemyField)
		}else if array_length(enemyHand) > 0{
			discardCard = array_pop(enemyHand)
		}else if array_length(playerHand) > 0{
			discardCard = array_pop(playerHand)
		}else{
			discarding = false
			discardCard = noone
			if array_length(startDeck) > 0{
				Deal()
			}else{
				Reshuffle()
				discardStep = 0
			}
		}
		if discardCard != noone{
			array_push(discardDeck,discardCard)
			discardCard.flipped = true
			discardCard.Move(obj_markDiscard.x,obj_markDiscard.y-4*discardStep)
			discardCard.depth = -discardStep
		}
	}
}

if reshuffling{
	if !reshuffleCard.moving{
		reshuffleStep += 1
		if array_length(discardDeck) > 0{
			reshuffleCard = array_pop(discardDeck)
			array_push(startDeck,reshuffleCard)
			reshuffleCard.Move(obj_markStart.x,obj_markStart.y-4*reshuffleStep)
			reshuffleCard.depth = -reshuffleStep
		}else{
			reshuffling = false
			alarm[0] = 30
		}
	}
}
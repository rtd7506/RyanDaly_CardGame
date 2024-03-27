/// @description Insert description here
// You can write your code in this editor

randomize()

//Containers
startDeck = []
playerHand = []
enemyHand = []
playerField = []
enemyField = []
discardDeck = []

dealing = false
picking = false
playing = false
battling = false
discarding = false
reshuffling = false

dealStep = 0
dealCard = noone
playCard = noone
discardStep = 0
discardCard = noone
reshuffleStep = 0
reshuffleCard = noone

playerScore = 0
enemyScore = 0
draw_set_font(fnt_font)

for (var i=0;i<24;i++){
	array_push(startDeck,instance_create_depth(x,y,0,obj_card))
}

function ToStart(){
	startDeck = array_shuffle(startDeck)
	for (var i=0;i<array_length(startDeck);i++){
		var card = startDeck[i]
		card.flipped = true
		card.Move(obj_markStart.x,obj_markStart.y-4*i)
		card.depth = -i
	}
	alarm[0] = 30
}

function Deal(){
	dealStep = 0
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
	dealing = true
}

function EnChoose(ind){
	var card = enemyHand[ind]
	array_push(enemyField,card)
	array_delete(enemyHand,ind,1)
	card.Move(obj_markEnField.x,obj_markEnField.y)
}

function Chosen(ind){
	var card = playerHand[ind]
	array_push(playerField,card)
	array_delete(playerHand,ind,1)
	picking = false
	playing = true
	card.Move(obj_markPlayField.x,obj_markPlayField.y)
	playCard = card
}

function Battle(){
	enemyField[0].flipped = false
	Score()
	alarm[1] = 30
}

function Score(){
	var playerThrow = playerField[0]._throw
	var enemyThrow = enemyField[0]._throw
	var winner = 0 //0: tie, 1: player, 2: enemy
	//0: Scissors
	//1: Paper
	//2: Rock
	if playerThrow == enemyThrow{
		winner = 0
	}else if playerThrow == 0{
		if enemyThrow == 1{
			winner = 1
		}else{
			winner = 2
		}
	}else if playerThrow == 1{
		if enemyThrow == 2{
			winner = 1
		}else{
			winner = 2
		}
	}else if playerThrow == 2{
		if enemyThrow == 0{
			winner = 1
		}else{
			winner = 2
		}
	}
	
	if winner == 1{
		playerScore += 1
	}else if winner == 2{
		enemyScore += 1
	}
}

function Discard(){
	discardCard = array_pop(playerField)
	array_push(discardDeck,discardCard)
	discardCard.flipped = true
	discardCard.Move(obj_markDiscard.x,obj_markDiscard.y-4*discardStep)
	discardCard.depth = -discardStep
	discarding = true
}

function Reshuffle(){
	reshuffleStep = 0
	reshuffleCard = array_pop(discardDeck)
	array_push(startDeck,reshuffleCard)
	reshuffleCard.Move(obj_markStart.x,obj_markStart.y-4*reshuffleStep)
	reshuffleCard.depth = -reshuffleStep
	reshuffleCard.Reroll()
	reshuffling = true
}

ToStart()
//
//  CardPlayLogic.m
//  Matchismo
//
//  Created by apple on 14-8-5.
//  Copyright (c) 2014年 Paradigm X. All rights reserved.
//

#import "CardPlayLogic.h"
#import "PlayingCardDeck.h"

@interface CardPlayLogic()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic, strong) Deck *deck;
@end

@implementation CardPlayLogic

- (PlayingCardDeck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (Deck *)deck
{
    if (! _deck) _deck = [self createDeck];
    return _deck;
}

-(NSMutableArray *) cards{
	if(!_cards) _cards = [[NSMutableArray alloc] init];
	return _cards;
}
-(instancetype) init:(NSUInteger) count{
	self = [super init];
    
	if(self){
		for(int i = 0; i < count; i++){
			Card *card = [self.deck drawRandomCard];
			[self.cards addObject:card];
		}
	}
	return self;
}

-(Card *)getCard:(NSUInteger)index{
	return self.cards[index];
}

-(void)selectCard:(NSUInteger) index{
	Card *card = self.cards[index];
    if(card.isMatched){
		return;
	}else if(card.isChosen){
		card.chosen = NO;
		return;
	}else{
		for(Card *tmpCard in self.cards){
			if(tmpCard.isChosen && !tmpCard.isMatched){
				int cardScore = [card match:@[tmpCard]];
				if(cardScore > 0){
					self.score += cardScore;
					tmpCard.matched = YES;
					card.matched = YES;
				}else{
					self.score--;
					tmpCard.chosen = NO;
				}
				break;
			}
		}
		card.chosen = YES;
	
	}
    
}


-(void)reset{
    _deck = [self createDeck];
    
    NSUInteger cardNum = [self.cards count];
    [self.cards removeAllObjects];
    for(int i = 0; i < cardNum; i++){
        Card *card = [self.deck drawRandomCard];
        [self.cards addObject:card];
    }
    self.score = 0;
    
}

-(BOOL) isGameEnd{
    NSMutableArray *noMatchedCards = [[NSMutableArray alloc] init];
    for(Card *tmpCard in self.cards){
        if(!tmpCard.isMatched){
            [noMatchedCards addObject:tmpCard];
        }
    }
    if([noMatchedCards count] > 2){
        return NO;
    }else if([noMatchedCards count] == 2){
        int tmpScore = [[noMatchedCards firstObject] match:@[[noMatchedCards lastObject]]];
        if (tmpScore > 0) {
            return NO;
        }else{
            return YES;
        }
    
    }else{
        return YES;
    }
}



@end


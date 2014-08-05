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
	if(_cards) _cards = [[NSMutableArray alloc] init];
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

-(void)selectCard:(NSUInteger) index{
//	Card *card = [self cardAtIndex:index];
    
    
}

@end


//
//  CardPlayLogic.h
//  Matchismo
//
//  Created by apple on 14-8-5.
//  Copyright (c) 2014年 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"


typedef struct {
    NSInteger flipCost;
    NSInteger mismatchPenalty;
    NSInteger matchBonus;
} ScoringDefinitions;

@interface CardPlayLogic : NSObject

/** Designated Initializer */
- (id)initWithCardCount:(NSUInteger)count
               fromDeck:(Deck *)deck
             matchCount:(NSUInteger)numCards
         bonusPenalties:(ScoringDefinitions)weights;

- (id)initWithCardCount:(NSUInteger)count
               fromDeck:(Deck *)deck;

@property (readonly, nonatomic) int score;
@property (nonatomic) NSUInteger numCardsToMatch;


- (NSArray *)lastPlays;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@end

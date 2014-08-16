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

@property (readwrite, nonatomic) int score;
@property (nonatomic) NSMutableArray *plays;
@property (nonatomic) NSMutableArray *cards;
@property (nonatomic, readonly) ScoringDefinitions weights;

@end

@implementation CardPlayLogic

- (id)initWithCardCount:(NSUInteger)count
               fromDeck:(Deck *)deck
             matchCount:(NSUInteger)numCards
         bonusPenalties:(ScoringDefinitions)weights
{
    self = [super init];
    if (self) {
        for (NSUInteger i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (!card) {
                self = nil;
                return self;
            }
            self.cards[i] = card;
        }
        self.numCardsToMatch = numCards;
        _weights = weights;
    }
    return self;
}

- (id)initWithCardCount:(NSUInteger)count fromDeck:(Deck *)deck
{
    return [self initWithCardCount:count
                          fromDeck:deck
                        matchCount:2
                    bonusPenalties:(ScoringDefinitions){-1, -1, 2}];
}

#pragma mark - Properties

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)plays
{
    if (!_plays) _plays = [[NSMutableArray alloc] init];
    return _plays;
}


- (void)flipCardAtIndex:(NSUInteger)index
{
    int playScore = 0;
    Card *card = [self cardAtIndex:index];
    
    BOOL(^isCardInPlay)(id, NSUInteger, BOOL*) = ^(id obj, NSUInteger idx, BOOL *stop) {
        return (BOOL)(![(Card *)obj isMatched] && [(Card *)obj isChosen]);
    };

    
    if (!card.matched) {
        if (!card.chosen) {
            NSArray *cardsInPlay = [self.cards objectsAtIndexes:[self.cards indexesOfObjectsPassingTest:isCardInPlay]];

            if ([cardsInPlay count] == self.numCardsToMatch - 1) {
                int cardScore = [card match:cardsInPlay];
                if (cardScore > 0) {
                    card.matched = YES;
                    [cardsInPlay enumerateObjectsUsingBlock:^(Card * obj, NSUInteger idx, BOOL *stop) {
                        obj.matched = YES;
                    }];
                    playScore += cardScore * self.weights.matchBonus * ((int)self.numCardsToMatch - 1);

                } else {
                    [cardsInPlay enumerateObjectsUsingBlock:^(Card * obj, NSUInteger idx, BOOL *stop) {
                        obj.chosen = NO;
                    }];
                    if (cardScore < 0) {
                        playScore += self.weights.mismatchPenalty * -cardScore;
                    } else {
                        playScore += self.weights.mismatchPenalty * ((int)self.numCardsToMatch - 1);
                    }

                }
            }
            playScore += self.weights.flipCost;

        }

        card.chosen = !card.chosen;
        self.score += playScore;

    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count])? self.cards[index] : nil;
}

- (NSString *)lastPlay
{
    return [self.plays lastObject];
}

- (NSArray *)lastPlays
{
    return [self.plays copy];
}




@end


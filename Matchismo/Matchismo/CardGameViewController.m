//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Neo on 7/31/14.
//  Copyright (c) 2014 Paradigm X. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardPlayLogic.h"

@interface CardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
//@property (weak, nonatomic) IBOutlet UILabel *flipsDisplay;
@property (weak, nonatomic) IBOutlet UILabel *scoreDisplay;
//@property (weak, nonatomic) IBOutlet UILabel *messageDisplay;
//@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSelector;
//@property (weak, nonatomic) IBOutlet UISlider *messageHistory;
//@property (nonatomic) int flipsCount;
@property (strong, nonatomic) CardPlayLogic *game;
@end

@implementation CardGameViewController



- (CardPlayLogic *)game
{
    if (!_game) _game = [[CardPlayLogic alloc] initWithCardCount:[self.cardButtons count]
                                                      fromDeck:[[PlayingCardDeck alloc] init]
                                                    matchCount:2
                                                bonusPenalties:(ScoringDefinitions){-1, -2, 4}];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];

        [cardButton setTitle:[self getCardTitle:card] forState:UIControlStateNormal];

        [cardButton setBackgroundImage:[self getCardBackgroundImage:card] forState:UIControlStateNormal];

        cardButton.enabled = !card.isMatched;

    }
    self.scoreDisplay.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

}


- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];

}

- (IBAction)dealGame {
    self.game = nil;
    [self updateUI];

}

-(NSString *) getCardTitle:(Card *)card{
	if(card.isChosen){
		return card.contents;
	}else{
		return @"";
	}
}

-(UIImage *)getCardBackgroundImage:(Card *)card{
	if(card.isChosen){
		return [UIImage imageNamed:@"CardFront"];
	}else{
		return [UIImage imageNamed:@"CardBack"];
	}
}


@end
//
//  SetGameViewController.m
//  Matchismo
//
//  Created by apple on 14-8-16.
//  Copyright (c) 2014年 Paradigm X. All rights reserved.
//
#import "SetGameViewController.h"
#import "SetDeck.h"
#import "CardPlayLogic.h"
#import "SetCard.h"
@interface CardGameViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@property (weak, nonatomic) IBOutlet UILabel *scoreDisplay;

@end

@implementation SetGameViewController

#pragma mark - Properties

- (CardPlayLogic *)game
{
    if (!_game) _game = [[CardPlayLogic alloc] initWithCardCount:[super.cardButtons count]
                                                  fromDeck:[[SetDeck alloc] init]
                                                matchCount:3
                                            bonusPenalties:(ScoringDefinitions){-3, -3, 4}];
    return _game;
}

#pragma mark - Methods

- (NSAttributedString *)attributedStringForCard:(SetCard *)card
{
    UIColor *cardColor, *fillColor, *strokeColor;
    NSNumber *strokeWidth;
    // color
    switch (card.color) {
        case SetCardColorPurple:
            cardColor = [UIColor purpleColor];
            break;
        case SetCardColorGreen:
            cardColor = [UIColor greenColor];
            break;
        case SetCardColorRed:
        default:
            cardColor = [UIColor redColor];
            break;
    }

    switch (card.shading) {
        case SetCardShadingOpen:
            fillColor = strokeColor = cardColor;
            strokeWidth = @5;
            break;
        case SetCardShadingStriped:
            fillColor = [cardColor colorWithAlphaComponent:0.10f];
            strokeColor = cardColor;
            strokeWidth = @-5;
            break;
        case SetCardShadingSolid:
        default:
            fillColor = strokeColor = cardColor;
            strokeWidth = @0;
            break;
    }
  
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0],
                                 NSForegroundColorAttributeName: fillColor,
                                 NSStrokeColorAttributeName: strokeColor,
                                 NSStrokeWidthAttributeName: strokeWidth};
    
    return [[NSAttributedString alloc] initWithString:card.contents
                                           attributes:attributes];
}


- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        SetCard *card = (SetCard *)[self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setAttributedTitle:[self attributedStringForCard:card] forState:UIControlStateNormal];
        

        if (card.isMatched) {
            cardButton.alpha = 0.0;
            [cardButton setBackgroundColor:[UIColor lightGrayColor]];
        } else if (card.isChosen) {
            cardButton.alpha = 0.75;
            [cardButton setBackgroundColor:[UIColor yellowColor]];
        } else {
            cardButton.alpha = 1.0;
            [cardButton setBackgroundColor:[UIColor clearColor]];
        }

        cardButton.selected = card.isChosen;
        cardButton.enabled = !card.isMatched;
    }

    self.scoreDisplay.text = [NSString stringWithFormat:@"Score: %d", self.game.score];

}

@end
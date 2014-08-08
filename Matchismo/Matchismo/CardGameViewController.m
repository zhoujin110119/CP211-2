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
@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
@property (nonatomic) int flipCount;
@property (strong,nonatomic) Deck *deck;
@property (strong,nonatomic) CardPlayLogic *playLogic;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;

@end

@implementation CardGameViewController

- (CardPlayLogic *)playLogic{
	if(!_playLogic) _playLogic = [[CardPlayLogic alloc] init:[self.cardButtons count]];
	return _playLogic;
}

- (IBAction)resetGame:(UIButton *)sender {
    [self.playLogic reset];
    [self updateUI];
}



- (IBAction)touchCardButton:(UIButton *)sender {
	NSUInteger chosenCardIndex = [self.cardButtons indexOfObject:sender];
	[self.playLogic selectCard:chosenCardIndex];
	[self updateUI];
    if ([self.playLogic isGameEnd]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"游戏结束" message:[NSString stringWithFormat:@"最终得分为: %ld", self.playLogic.score] delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
        [alert show];
        [self.playLogic reset];
        [self updateUI];
    }
}

-(void) updateUI{
    for(UIButton *cardButton in self.cardButtons){
		NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
		Card *card = [self.playLogic getCard:cardButtonIndex];
		[cardButton setTitle:[self getCardTitle:card] forState:UIControlStateNormal];
		[cardButton setBackgroundImage:[self getCardBackgroundImage:card] forState:UIControlStateNormal];
        
        cardButton.enabled = !card.isMatched;
		self.flipsLable.text = [NSString stringWithFormat:@"Score: %ld", self.playLogic.score];
	}

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

//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Neo on 7/31/14.
//  Copyright (c) 2014 Paradigm X. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLable;
@property (nonatomic) int flipCount;
@property (strong,nonatomic) Deck *deck;

@end

@implementation CardGameViewController


- (void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    
    self.flipsLable.text = [NSString stringWithFormat:@"Flips:%d",self.flipCount];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if ([[sender currentTitle] length])
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"CardBack"] forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }
    else{
        Card *card = [self.deck drawRandomCard];
        [sender setBackgroundImage:[UIImage imageNamed:@"CardFront"] forState:UIControlStateNormal];
        [sender setTitle:@"A" forState:UIControlStateNormal];
    }
    
    self.flipCount++;
    
    //[self setFlipCount:self.flipCount];
    
}

@end

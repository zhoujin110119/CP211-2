//
//  SetDeck.m
//  Matchismo
//
//  Created by apple on 14-8-16.
//  Copyright (c) 2014年 Paradigm X. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"
@implementation SetDeck
- (id)init
{
    self = [super init];
    if (self) {
        for (NSUInteger number = 1; number <= 3; number++) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (SetCardShadingType shade = 0; shade < SET_CARD_SHADING_TYPE_COUNT; shade++) {
                    for (SetCardColorType color = 0; color < SET_CARD_COLOR_TYPE_COUNT; color++) {
                        SetCard *card = [[SetCard alloc] initWithNumber:number
                                                                shading:shade
                                                                  color:color
                                                                 symbol:symbol];
                        if (card) [self addCard:card atTop:YES];
                    }
                }
            }
            
        }
    }
    return self;
}
@end

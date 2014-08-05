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
@interface CardPlayLogic : NSObject

-(instancetype) init:(NSUInteger) count;

-(void)selectCard:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;

@end

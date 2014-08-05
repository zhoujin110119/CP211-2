//
//  CardPlayLogic.h
//  Matchismo
//
//  Created by Neo on 8/5/14.
//  Copyright (c) 2014 Paradigm X. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardPlayLogic : NSObject

-(instancetype) init:(NSUInteger) count;

-(void)selectCard:(NSUInteger) index;

@property (nonatomic, readonly) NSInteger score;

@end

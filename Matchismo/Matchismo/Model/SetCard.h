//
//  SetCard.h
//  Matchismo
//
//  Created by apple on 14-8-16.
//  Copyright (c) 2014年 Paradigm X. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Card.h"


extern NSString * const SetCardSymbolDiamond;
extern NSString * const SetCardSymbolSquiggle;
extern NSString * const SetCardSymbolOval;

typedef NS_ENUM(NSInteger, SetCardShadingType) {
    SetCardShadingSolid,
    SetCardShadingStriped,
    SetCardShadingOpen,
    SET_CARD_SHADING_TYPE_COUNT
};

typedef NS_ENUM(NSInteger, SetCardColorType) {
    SetCardColorRed,
    SetCardColorGreen,
    SetCardColorPurple,
    SET_CARD_COLOR_TYPE_COUNT
};


@interface SetCard : Card


- (id)initWithNumber:(NSUInteger)number
             shading:(SetCardShadingType)shading
               color:(SetCardColorType)color
              symbol:(NSString *)symbol;

/** number = one, two, or three. */
@property (readonly, nonatomic) NSUInteger number;

/** symbol = diamond, squiggle, oval. */
@property (readonly, strong, nonatomic) NSString *symbol;

/** shading = solid, striped, or open. */
@property (readonly, nonatomic) SetCardShadingType shading;

/** color = red, green, or purple. */
@property (readonly, nonatomic) SetCardColorType color;

/** List of NSString symbols allowed for the Set cards. */
+ (NSArray *)validSymbols;


@end

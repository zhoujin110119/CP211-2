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

@property (readonly, nonatomic) NSUInteger number;


@property (readonly, strong, nonatomic) NSString *symbol;


@property (readonly, nonatomic) SetCardShadingType shading;

@property (readonly, nonatomic) SetCardColorType color;

+ (NSArray *)validSymbols;


@end

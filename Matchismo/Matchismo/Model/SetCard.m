//
//  SetCard.m
//  Matchismo
//
//  Created by apple on 14-8-16.
//  Copyright (c) 2014年 Paradigm X. All rights reserved.
//

#import "SetCard.h"

NSString * const SetCardSymbolDiamond = @"▲";
NSString * const SetCardSymbolSquiggle = @"■";
NSString * const SetCardSymbolOval = @"●";

@implementation SetCard


+ (BOOL)allSameOrDifferent:(SEL)property forArray:(NSArray *)cards
{
    return ([self allElementsInArray:cards haveTheSame:property])
    || ([self allElementsInArray:cards haveDistinct:property]);
}

+ (BOOL)allElementsInArray:(NSArray *)cards haveTheSame:(SEL)property
{
    return (1 == [self countUniquePropertyValuesFor:property inCards:cards]);
}

+ (BOOL)allElementsInArray:(NSArray *)cards haveDistinct:(SEL)property
{
    return ([cards count] == [self countUniquePropertyValuesFor:property inCards:cards]);
}


+ (NSUInteger)countUniquePropertyValuesFor:(SEL)property inCards:(NSArray *)cards
{
    NSString *propertyName = NSStringFromSelector(property);
    NSArray *propertyValues = [cards valueForKey:propertyName];
    NSSet *uniquePropertyValues = [NSSet setWithArray:propertyValues];
    return [uniquePropertyValues count];
}

+ (NSArray *)validSymbols
{
    static NSArray *symbols = nil;
    if (!symbols) symbols = @[SetCardSymbolDiamond, SetCardSymbolOval, SetCardSymbolSquiggle];
    return symbols;
}

#pragma mark - Initialization

- (id)initWithNumber:(NSUInteger)number
             shading:(SetCardShadingType)shading
               color:(SetCardColorType)color
              symbol:(NSString *)symbol
{
    self = [super init];
    if (self) {
        if (!(number >= 1 && number <= 3)
            || !(shading >= 0 && shading < SET_CARD_SHADING_TYPE_COUNT)
            || !(color >= 0 && color < SET_CARD_COLOR_TYPE_COUNT)
            || ![[SetCard validSymbols] containsObject:symbol])
        {
            return nil;
        }
                _number = number;
        _symbol = symbol;
        _shading = shading;
        _color = color;
    }
    return self;
}

- (id)init
{
    return [self initWithNumber:1
                        shading:SetCardShadingSolid
                          color:SetCardColorRed
                         symbol:[SetCard validSymbols][0]];
}


- (NSString *)contents
{
    return [@"" stringByPaddingToLength:self.number withString:self.symbol startingAtIndex:0];
}

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    BOOL(^isSameClass)(id, NSUInteger, BOOL*) = ^(id obj, NSUInteger idx, BOOL *stop) {
        return [obj isKindOfClass:[SetCard class]];
    };
    BOOL isOnlySetCards = ([otherCards count] == [[otherCards indexesOfObjectsPassingTest:isSameClass] count]);
    
    if ([otherCards count] > 0 && isOnlySetCards) {
        NSArray *allCards = [otherCards arrayByAddingObject:self];

        if (![SetCard allSameOrDifferent:@selector(number) forArray:allCards]) score--;
        if (![SetCard allSameOrDifferent:@selector(shading) forArray:allCards]) score--;
        if (![SetCard allSameOrDifferent:@selector(color) forArray:allCards]) score--;
        if (![SetCard allSameOrDifferent:@selector(symbol) forArray:allCards]) score--;
        
        if (!(score < 0)) score = 3;
    }
    return score;
}

@end


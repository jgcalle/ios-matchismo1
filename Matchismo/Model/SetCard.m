//
//  SetCard.m
//  Matchismo
//
//  Created by MIMO on 22/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (NSString *)contents
{
    NSString *contents = [[NSString alloc] init];
    for (NSUInteger i=1; i <= self.number; i++) {
        contents = [contents stringByAppendingFormat:@"%@",self.symbol];
    }
    return contents;
}

- (void)setNumber:(NSUInteger)number
{
    if (number >= 1 && number <= [[self class] maxNumber]) _number = number;
}

- (void) setSymbol:(NSString *)symbol
{
    if ([[[self class] validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void) setShading:(NSString *)shading
{
    if ([[[self class] validShadings] containsObject:shading]) {
        _shading = shading;
    }
}


- (void) setColor:(NSString *)color
{
    if ([[[self class] validColors] containsObject:color ]) {
        _color = color;
    }
}

// Set game scores
#define SET 1

- (int)match:(NSArray *)otherCards {
    
    int score = 0;
    
    // 2 cards match
    if ([otherCards count] == 1) {
        SetCard *othercard1 = [otherCards objectAtIndex:0];
        // Number
        if (othercard1.number == self.number)  {
            // Symbol
            if ([othercard1.symbol isEqualToString:self.symbol] || [othercard1.shading isEqualToString:self.shading] || [othercard1.color isEqualToString:self.color]) {
                score = SET;
            }
        }
        
    }
    return score;
}

+ (NSUInteger)maxNumber
{
    return 3;
}

+ (NSArray *)validSymbols {
    return @[@"▲", @"●", @"■"];
}

+ (NSArray *)validShadings {
    return @[@"solid",@"striped",@"open"];
}

+ (NSArray *)validColors {
    return @[@"red",@"green",@"blue"];
}

@end

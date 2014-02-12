//
//  SetCard.h
//  Matchismo
//
//  Created by MIMO on 22/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

#pragma mark - Properties
@property (nonatomic) NSUInteger number;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *shading;
@property (strong, nonatomic) NSString *color;

#pragma mark - Class utility methods
+ (NSUInteger)maxNumber;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

@end


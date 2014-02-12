//
//  PlayingCard.h
//  cards
//
//  Created by MIMO on 10/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

#pragma mark - Properties
@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

#pragma mark - Class utility methods
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end

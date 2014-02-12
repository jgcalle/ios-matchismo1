//
//  MatchGame.m
//  Matchismo
//
//  Created by MIMO on 22/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "MatchGame.h"

@implementation MatchGame

#pragma mark - Getters & Setters

- (NSUInteger) numberCardsToMatch {
    return 2;
}

- (NSUInteger) flipCost {
    return 1;
}

- (NSUInteger) matchBonus {
    return 4;
}

- (NSUInteger) mismatchPenalty {
    return 2;
}

@end

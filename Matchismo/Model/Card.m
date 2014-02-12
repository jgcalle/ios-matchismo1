//
//  Card.m
//  cards
//
//  Created by MIMO on 10/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card


- (int)match: (NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

- (NSString *)description
{
    return self.contents;
}

@end

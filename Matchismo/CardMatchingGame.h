//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by MIMO on 13/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck;

- (void) chooseCardAtIndex:(NSUInteger)index;

- (Card *) cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSInteger score;
@property (nonatomic,readonly) NSMutableArray *historyFlips;

@end

//
//  Deck.h
//  cards
//
//  Created by MIMO on 10/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;

@end
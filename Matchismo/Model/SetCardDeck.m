//
//  SetCardDeck.m
//  Matchismo
//
//  Created by MIMO on 22/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck


-(instancetype)init {
    
    self = [super init];
    
    if(self){
        for (NSString *symbol in [SetCard validSymbols]) {
            for (NSString *color in [SetCard validColors]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSUInteger number=1; number <= [SetCard maxNumber]; number++) {
                
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.symbol = symbol;
                        card.color = color;
                        card.shading = shading;
                        [self addCard:card atTop:NO];
                        
                    }
                }
            }
        }
    }
    return self;
    
}


@end

//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by MIMO on 13/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "CardMatchingGame.h"
#import "CardMatchingGameMovement.h"

@interface CardMatchingGame()

@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,readwrite) NSMutableArray *historyFlips;
@property (nonatomic,strong) NSMutableArray *cards; // of Card

// Number of card needed to perform a match
// (subclasses must implement getter)
@property (nonatomic, readonly) NSUInteger numberCardsToMatch;

// Score parameters
// (subclasses must implement getters)
@property (nonatomic, readonly) NSUInteger flipCost;
@property (nonatomic, readonly) NSUInteger matchBonus;
@property (nonatomic, readonly) NSUInteger mismatchPenalty;

@end

@implementation CardMatchingGame

-(NSMutableArray *) historyFlips
{
    if (!_historyFlips) _historyFlips = [[NSMutableArray alloc] init];
    return _historyFlips;
}

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    
    self = [super init];
    
    if (self) {
        for (int i=0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            };
        }
    }
    return self;
}

- (void) chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    CardMatchingGameMovement* lastMovement = [[CardMatchingGameMovement alloc] init];
    
    if (!card.isMatched) {
        if (card.chosen) {
            card.chosen = NO;
        } else {
            // match againts another card
            
            // Movement
            lastMovement.movementType = FLIP;
            lastMovement.score = self.flipCost;
            lastMovement.cards = @[card];
            
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        self.score += matchScore * self.matchBonus;
                        card.matched = YES;
                        otherCard.matched = YES;
                        
                        // Movement
                        lastMovement.movementType = MATCH;
                        lastMovement.score = matchScore * self.matchBonus;
                        lastMovement.cards = @[card,otherCard];
                        
                    } else {
                        self.score -= self.mismatchPenalty;
                        otherCard.chosen = NO;
                        
                        // Movement
                        lastMovement.movementType = MISMATCH;
                        lastMovement.score = self.mismatchPenalty;
                        lastMovement.cards = @[otherCard, card];
                    }

                    break;
                }
            }
            [self.historyFlips addObject:lastMovement];
            self.score -= self.flipCost;
            card.chosen = YES;
        }
    }
    
}


- (Card *) cardAtIndex:(NSUInteger)index {

    if (index < [self.cards count] ) {
        return [self.cards objectAtIndex:index];
    } else {
        return nil;
    }

}


-(instancetype) init {
    return nil;
}


@end

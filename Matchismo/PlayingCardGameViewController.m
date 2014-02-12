//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by MIMO on 15/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "MatchGame.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController


#pragma mark - Getters & Setters

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (Class)gameClass
{
    return [MatchGame class];
}


#pragma mark - Update UI

- (void)setCardButtonUI:(UIButton *)cardButton
                forCard:(Card *)card
{
    // Title
    [cardButton setTitle:[self titleForCard:card]
                forState:UIControlStateNormal];
    
    // Back image
    [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                          forState:UIControlStateNormal];

    // State
    cardButton.alpha = card.isMatched ? 0.3 : 1.0;
}

- (NSString *) titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *) backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (void)setFlipDescriptionLabelUI:(UILabel *)flipDescriptionLabel
                      forMovement:(CardMatchingGameMovement *)movement
{
    
    NSString *cardsString = [movement.cards componentsJoinedByString:@" & "];
    
    switch (movement.movementType) {
        case FLIP:
            flipDescriptionLabel.text = [NSString stringWithFormat:@"Flipped up %@", cardsString];
            break;
        case MATCH:
            flipDescriptionLabel.text = [NSString stringWithFormat:@"Matched %@ for %d points", cardsString, movement.score];
            break;
        case MISMATCH:
            flipDescriptionLabel.text = [NSString stringWithFormat:@"%@ don't match (%d points penalty)", cardsString, movement.score];
            break;
        default: break;
    }
    
    if (!movement) flipDescriptionLabel.text = @"";
    
}

@end

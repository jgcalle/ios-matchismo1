//
//  CardGameViewController.h
//  Matchismo
//
//  Created by MIMO on 10/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//
//  Abstract class. Must implement methods as described below

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGameMovement.h"

@interface CardGameViewController : UIViewController

#pragma mark - Abstract methods

- (Deck *)createDeck;   // Abstract Return a new deck (subclass of Deck)

// Return the class (subclass of CardMatchingGame)
// of the viewController's game property
- (Class)gameClass;


// Set all the UI parameters of the card button using the card
- (void)setCardButtonUI:(UIButton *)cardButton
                forCard:(Card *)card;

// Set all the UI parameters of the description label using the movement
- (void)setFlipDescriptionLabelUI:(UILabel *)flipDescriptionLabel
                      forMovement:(CardMatchingGameMovement *)movement;

@end

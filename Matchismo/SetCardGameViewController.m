//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by MIMO on 17/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetGame.h"
#import "SetCard.h"
#import "SetCardDeck.h"
#import "CardMatchingGameMovement.h"


@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

#pragma mark - Getters & Setters

- (Deck *) createDeck {
    return [[SetCardDeck alloc] init];
}

- (Class)gameClass
{
    return [SetGame class];
}

#pragma mark - Update UI

- (NSAttributedString *)attributedStringForSetCard:(SetCard *)card
{
    NSAttributedString *attributedString = nil;
    
    if (card) {
        
        float alpha = 0.0;
        UIColor *foregroundColor = nil;
        UIColor *strokeColor = nil;
        
        // Shading
        if ([card.shading isEqualToString:@"solid"]) {
            alpha = 1.0;
        } else if ([card.shading isEqualToString:@"striped"]) {
            alpha = 0.1;
        } else if ([card.shading isEqualToString:@"open"]) {
            alpha = 0.0;
        }
        
        
        // Color
        if ([card.color isEqualToString:@"red"]) {
            foregroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:alpha];
            strokeColor = [UIColor redColor];
        } else if ([card.color isEqualToString:@"green"]) {
            foregroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:alpha];
            strokeColor = [UIColor greenColor];
        } else if ([card.color isEqualToString:@"blue"]) {
            foregroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:alpha];
            strokeColor = [UIColor blueColor];
        }
        
        NSDictionary *attributes = @{
                                     NSForegroundColorAttributeName : foregroundColor,
                                     NSStrokeColorAttributeName : strokeColor,
                                     NSStrokeWidthAttributeName :@"-3.0"
                                     };
        
        attributedString = [[NSAttributedString alloc] initWithString:card.contents attributes:attributes];
        
    }
    
    return attributedString;
}

- (void)setCardButtonUI:(UIButton *)cardButton forCard:(Card *)card
{

    // Title
    [cardButton setAttributedTitle:[self attributedStringForSetCard:(SetCard *)card] forState:UIControlStateNormal];
    
    
    // Back image
    [cardButton setBackgroundColor:[self backgroundColorForCard:card]];
     
    
    // State
    cardButton.alpha = card.isMatched ? 0.0 : 1.0;
}


- (UIColor *) backgroundColorForCard:(Card *)card {
    return card.isChosen ? [UIColor whiteColor] : [UIColor colorWithRed:0.9
                                                 green:0.9
                                                  blue:0.9
                                                 alpha:1.0];
}

- (void)setFlipDescriptionLabelUI:(UILabel *)flipDescriptionLabel
                      forMovement:(CardMatchingGameMovement *)movement
{
    
    NSMutableAttributedString *description = nil;
    NSString *points = nil;
    
    NSMutableAttributedString *cardsString = [[NSMutableAttributedString alloc] init];
    BOOL first = YES;
    for (Card *card in movement.cards) {
        if (first) {
            first = NO;
        } else {
            [cardsString appendAttributedString:[[NSAttributedString alloc] initWithString:@" & "]];
        }
        [cardsString appendAttributedString:[self attributedStringForSetCard:(SetCard *)card]];
    }

    
    switch (movement.movementType) {
        case FLIP:
            description = [[NSMutableAttributedString alloc] initWithString:@"Selected "];
            [description appendAttributedString:cardsString];
            break;
        case MATCH:
            description = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            [description appendAttributedString:cardsString];
            points = [NSString stringWithFormat:@" for %d points",movement.score];
            [description appendAttributedString:[[NSAttributedString alloc] initWithString:points]];
            break;
        case MISMATCH:
            description = [[NSMutableAttributedString alloc] initWithString:@"Don't match "];
            [description appendAttributedString:cardsString];
            points = [NSString stringWithFormat:@" (%d points penalty)",movement.score];
            [description appendAttributedString:[[NSAttributedString alloc] initWithString:points]];
            break;
        default: break;
    }
    
    // Font & Paragraph style
    flipDescriptionLabel.font = [UIFont systemFontOfSize:11];
    flipDescriptionLabel.textAlignment = NSTextAlignmentCenter;
    
    if (!movement) {
        flipDescriptionLabel.attributedText = [[NSAttributedString alloc] initWithString:@""];
    } else {
        flipDescriptionLabel.attributedText = description;
    }
    NSLog(description.description,nil);
    
}

@end

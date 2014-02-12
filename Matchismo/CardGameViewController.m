//
//  CardGameViewController.m
//  Matchismo
//
//  Created by MIMO on 10/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import "CardGameViewController.h"
#import "CardMatchingGame.h"
#import "CardMatchingGameMovement.h"

@interface CardGameViewController ()

// Model
@property (strong,nonatomic) CardMatchingGame *game;

// Outlets
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UISlider *sliderHistory;

@end

@implementation CardGameViewController

#pragma mark - Getters & Setters

- (CardMatchingGame *)game {
    if (!_game) _game = [[[self gameClass] alloc] initWithCardCount:[self.cardButtons count]
                                                   usingDeck:[self createDeck]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (Deck *)createDeck    // Abstract
{
    return [[Deck alloc] init];
}

- (Class) gameClass
{
    return [CardMatchingGame class];
}


#pragma mark - Actions

- (IBAction)showHistory:(UISlider *)sender {
    
    if ([self.game.historyFlips count]) {
        
        [sender setValue:(float)roundl([(UISlider *)sender value])];    // Rounds float to an integer and sets your slider to this value
        
        [self setFlipDescriptionLabelUI:self.statusLabel forMovement:[self.game.historyFlips objectAtIndex:sender.value]];
        
        self.sliderHistory.alpha = (self.sliderHistory.value == self.sliderHistory.maximumValue) ? 1.0 : 0.75;
    }
    
}

- (IBAction)touchCardButtom:(UIButton *)sender {
    
    [self.game chooseCardAtIndex:[self.cardButtons indexOfObject:sender]];
    
    [self updateUI];
}

- (IBAction)deal {
    
    self.game = nil;
    
    self.sliderHistory.maximumValue = 0;
    
    [self updateUI];
    
}

#pragma mark - Update UI

- (void)updateUI {
    
    // Cards buttons
    for (UIButton *cardButton in self.cardButtons) {
        
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        
        cardButton.enabled = !card.isMatched;
        cardButton.selected = card.isChosen;
        
        [self setCardButtonUI:cardButton forCard:card];
    }
    
    // Score label
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d",self.game.score];
    
    
    // Status label
    self.statusLabel.text = @"";
    if ([self.game.historyFlips count]) {
        [self.sliderHistory setEnabled:YES];
        self.sliderHistory.maximumValue = [self.game.historyFlips count] - 1;
        self.sliderHistory.value = self.sliderHistory.maximumValue;
        self.sliderHistory.alpha = (self.sliderHistory.value == self.sliderHistory.maximumValue) ? 1.0 : 0.5;

        [self setFlipDescriptionLabelUI:self.statusLabel forMovement:[self.game.historyFlips lastObject]];
    }

    
}

// Subclass must implement
- (void)setCardButtonUI:(UIButton *)cardButton
                forCard:(Card *)card
{
    
}

// Subclass must implement
- (void)setFlipDescriptionLabelUI:(UILabel *)flipDescriptionLabel
                      forMovement:(CardMatchingGameMovement *)movement
{
    
}


@end

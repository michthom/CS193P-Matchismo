//
//  Matchismo_ViewController.m
//  CS193P Matchismo
//
//  Created by Michael Thomson on 17/03/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "Matchismo_ViewController.h"

@implementation Matchismo_ViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        [self setupGame:_game];
    }
    return _game;
}

- (void)setupGame:(CardMatchingGame *)game
{
    // abstract
}

- (Deck *)createDeck
{
    return nil; // abstract
}

- (void)viewWillAppear:(BOOL)animated
{
    [self updateUI];
}

- (void)updateUI
{
    // abstract
}

- (IBAction)flipSliderMoved:(UISlider *)sender
{
    if ([self.game.previousStates count] > 1) {
        int roundedValue = (int)roundf(sender.value);
        [self.game.lastMatchedCards removeAllObjects];
        [self.game restoreStateForFlipCount:roundedValue];
        [self updateUI];
    }
}

- (IBAction)newDeal:(UIButton *)sender
{
    // New game will be created on next access by the getter above.
    self.game = nil;
    
    [self.flipSlider setMinimumValue:0];
    [self.flipSlider setMaximumValue:0];
    
    [self updateUI];
}

- (IBAction)flipCard:(UIButton *)sender
{
    if (!self.game.isInProgress) {
        // As soon as the first flip happens, the game starts.
        self.game.inProgress = TRUE;
    }
    
    if (self.game.flipCount != [self.game.previousStates count] - 1) {
        [self.game restoreStateForFlipCount:([self.game.previousStates count] - 1)];
    } else {
        self.game.flipCount++;
        
        [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
        
        [self.game storeState];
    }
    
    [self.flipSlider setMaximumValue:[self.game.previousStates count] - 1];
    [self.flipSlider setValue:self.game.flipCount animated:NO];
    
    [self updateUI];
}

@end

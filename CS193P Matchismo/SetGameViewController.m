//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Michael Thomson on 23/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "SetGameViewController.h"

@implementation SetGameViewController

- (Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (void)setupGame:(CardMatchingGame *)game
{
    game.flipCostValue = 1;
    game.misMatchPenaltyValue = 2;
    game.matchBonusValue = 12;
    game.numberOfCardsToMatch = 3;
}

- (void)updateUI
{
    
#define CURRENT_ALPHA 1.0
#define HISTORIC_ALPHA 0.3
    
    if (self.game.flipCount != [self.game.previousStates count] - 1) {
        self.flipsLabel.alpha = HISTORIC_ALPHA;
        self.scoreLabel.alpha = HISTORIC_ALPHA;
        self.narrativeLabel.alpha = HISTORIC_ALPHA;
    } else {
        self.flipsLabel.alpha = CURRENT_ALPHA;
        self.scoreLabel.alpha = CURRENT_ALPHA;
        self.narrativeLabel.alpha = CURRENT_ALPHA;
    }
    
    for (UIButton *cardButton in self.cardButtons) {
        
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        if ([card isKindOfClass:[SetCard class]]) {
            
            cardButton.enabled = !card.isUnplayable;
            
            SetCard *setCard = (SetCard *)card;
            NSString *newText = [setCard contents];
            
            NSRange range = [newText rangeOfString:newText];
            
            NSAttributedString *result = [self attributedContentsOfSetCard:setCard];
            
            if ((range.location != NSNotFound) & (cardButton.isEnabled)) {
                [cardButton setAttributedTitle:result forState:UIControlStateNormal];
                [cardButton setAttributedTitle:result forState:UIControlStateSelected];
                [cardButton setAttributedTitle:result forState:UIControlStateSelected | UIControlStateDisabled];
            } else {
                NSAttributedString *blank = [[NSAttributedString alloc] initWithString:@""];
                // Blank the card
                [cardButton setAttributedTitle:blank forState:UIControlStateNormal];
                [cardButton setAttributedTitle:blank forState:UIControlStateSelected];
                [cardButton setAttributedTitle:blank forState:UIControlStateSelected | UIControlStateDisabled];
            }
            
            if (card.isFaceUp) {
                cardButton.selected = YES;
                [cardButton setBackgroundColor:[UIColor colorWithRed:0.9f green:0.9f blue:0.9f alpha:0.5f]];
                
            } else {
                cardButton.selected = NO;
                [cardButton setBackgroundColor:[UIColor whiteColor]];
            }
            
        }
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.game.flipCount];

    if ([self.game.lastMatchedCards count] == 0) {
        
        // Flipped down
        [self.narrativeLabel setAttributedText:[[NSAttributedString alloc] initWithString:@""]];
        
    } else {
        
        NSMutableString *nonAttributedText = [self.game.narrative mutableCopy];
        NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:nonAttributedText];

        for (SetCard *oneCard in self.game.lastMatchedCards) {
            NSString *searchString = [NSString stringWithFormat:@"(%@)",[oneCard contents]];
            NSRange range = [nonAttributedText rangeOfString:searchString];
            
            if (range.location != NSNotFound) {
                [attributedText replaceCharactersInRange:range withAttributedString:[self attributedContentsOfSetCard:oneCard]];
                
                nonAttributedText = [[nonAttributedText stringByReplacingCharactersInRange:range withString:oneCard.contents] mutableCopy];
            }
        }
        
        [self.narrativeLabel setAttributedText:attributedText];
        
    }
}

- (NSAttributedString *)attributedContentsOfSetCard:(SetCard *)card
{
    NSString *newText = [card contents];
    
    NSRange range = [newText rangeOfString:newText];
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:newText];
    
    if ((range.location != NSNotFound)) {
        // Need to create the AtributedString here...
        
        CGFloat alpha;
        UIColor *strokeColour;
        UIColor *fillColour;
        
        
        // NSStrokeWidthAttributeName : @(-2.0)
        // NSStrokeColorAttributeName :
        
        if ([card.shading isEqualToString:@"solid"]) {
            alpha = 1.0;
        } else if ([card.shading isEqualToString:@"striped"]) {
            alpha = 0.3;
        } else if ([card.shading isEqualToString:@"hollow"]) {
            alpha = 0.0;
        } else {
            // Something went wrong
            alpha = 0.1;
        }
        
        if ([card.colour isEqualToString:@"red"]) {
            strokeColour = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0];
            fillColour = [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:alpha];
            
        } else if ([card.colour isEqualToString:@"green"]) {
            strokeColour = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1.0];
            fillColour = [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:alpha];
            
        } else if ([card.colour isEqualToString:@"purple"]) {
            strokeColour = [UIColor colorWithRed:1.0f green:0.0f blue:1.0f alpha:1.0];
            fillColour = [UIColor colorWithRed:1.0f green:0.0f blue:1.0f alpha:alpha];
            
        } else {
            // Something went wrong
            strokeColour = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0];
            fillColour = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:alpha];
        }
        
        NSDictionary *attributes = @{ NSStrokeColorAttributeName : strokeColour,
                                      NSStrokeWidthAttributeName : @-10.0f,
                                      NSForegroundColorAttributeName : fillColour,
                                      };
        
        [result addAttributes:attributes range:range];
    } else {
        NSLog(@"Whoopsie!");
    }
    return result;
}

@end
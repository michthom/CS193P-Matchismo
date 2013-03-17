//
//  Card.m
//  HW1
//
//  Created by Michael Thomson on 20/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}


@end

//
//  PlayingCard.h
//  HW1
//
//  Created by Michael Thomson on 20/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) int rank;

+ (NSArray *)validSuits;
+ (NSArray *)rankStrings;
+ (NSUInteger)maxRank;

@end

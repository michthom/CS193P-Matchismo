//
//  SetCard.h
//  Matchismo
//
//  Created by Michael Thomson on 23/02/2013.
//  Copyright (c) 2013 Michael Thomson. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *contents;

@property (strong, nonatomic) NSString *shape;
@property (strong, nonatomic) NSString *colour;
@property (strong, nonatomic) NSString *shading;
@property (nonatomic) int               count;

- (int)match:(NSArray *)otherCards;

+ (NSArray *)validShapes;
+ (NSArray *)validColours;
+ (NSArray *)validShadings;
+ (NSUInteger)maxCount;

@end

//
//  CardMatchingGameMovement.h
//  Matchismo
//
//  Created by MIMO on 22/01/14.
//  Copyright (c) 2014 MIMO. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSUInteger, MovementType) {
    FLIP,
    MATCH,
    MISMATCH
};


@interface CardMatchingGameMovement : NSObject

#pragma mark - Properties

@property (nonatomic) MovementType movementType;
@property (strong, nonatomic) NSArray *cards;   // of Card
@property (nonatomic) NSUInteger score;

@end

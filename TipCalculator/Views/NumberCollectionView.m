//
//  NumberCollectionView.m
//  TipCalculator
//
//  Created by Charlie Massry on 3/27/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "NumberCollectionView.h"
#import "NumberView.h"
#import "Util.h"

@interface NumberCollectionView ()
@property (strong, nonatomic) NSArray *numberViews;
@end

@implementation NumberCollectionView

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        NSMutableArray *tmpNumberViews = [[NSMutableArray alloc] init];
        for (NSString *buttonFace in [Util buttonFaces]) {
            NumberView *numberView = [[NumberView alloc] initWithButtonFace:buttonFace];
            [tmpNumberViews addObject:numberView];
            [self addSubview:numberView];
        }
        
        self.numberViews = tmpNumberViews;
        
        [self updateConstraints];
    }
    return self;
}

#pragma mark - LayoutConstraints

- (void)updateConstraints {
    [self addConstraintsForNumberViews];
    [super updateConstraints];
}

-(void)addConstraintsForNumberViews {
    for (NSUInteger i = 0; i < 12; i++) {
        [self addConstraints:[self constraintsForNumberView:self.numberViews[i] withIndex:i]];
    }
}

-(NSArray *)constraintsForNumberView:(NumberView *)numberView withIndex:(NSUInteger)index{
    numberView.translatesAutoresizingMaskIntoConstraints = NO;
    
    CGFloat circleMultiplier = 0.25;
    CGFloat verticalMultiplier = [self verticalMultiplierForIndex:index];
    CGFloat horizontalMultiplier = [self horizonalMultiplierForIndex:index];
    
    NSLayoutConstraint *constraintWidth = [self setConstraintMultiplier:circleMultiplier
                                                          forNumberView:numberView
                                                            andPosition:NSLayoutAttributeWidth];
    NSLayoutConstraint *constraintHeight = [self setConstraintMultiplier:circleMultiplier
                                                           forNumberView:numberView
                                                             andPosition:NSLayoutAttributeHeight];
    NSLayoutConstraint *horizontalConstraint = [self setConstraintMultiplier:horizontalMultiplier
                                                               forNumberView:numberView
                                                                 andPosition:NSLayoutAttributeCenterX];
    NSLayoutConstraint *verticalConstraint = [self setConstraintMultiplier:verticalMultiplier
                                                             forNumberView:numberView
                                                               andPosition:NSLayoutAttributeCenterY];
    return @[
             constraintWidth,
             constraintHeight,
             horizontalConstraint,
             verticalConstraint
             ];
}

-(NSLayoutConstraint *)setConstraintMultiplier:(CGFloat)multiplier forNumberView:(NumberView *)numberView andPosition:(NSLayoutAttribute)position {
    return [NSLayoutConstraint constraintWithItem:numberView
                                        attribute:position
                                        relatedBy:NSLayoutRelationEqual
                                           toItem:self
                                        attribute:position
                                       multiplier:multiplier
                                         constant:0];
}

-(CGFloat)horizonalMultiplierForIndex:(NSUInteger)index {
    NSArray *leftArray   = @[@0, @3, @6, @9];
    NSArray *middleArray = @[@1, @4, @7, @10];
//    NSArray *rightArray  = @[@2, @5, @8, @11];
    
    NSString *position;
    
    if ([leftArray containsObject:[NSNumber numberWithUnsignedInteger:index]]) {
        position = @"left";
    } else if ([middleArray containsObject:[NSNumber numberWithUnsignedInteger:index]]){
        position = @"middle";
    } else {
        position = @"right";
    }
    
    NSNumber *leftMultiplier = @0.3;
    NSNumber *middleMultiplier = @1;
    NSNumber *rightMultiplier = @1.7;

    NSDictionary *horizontalMultiplierDictionary = @{
                                                     @"left" : leftMultiplier,
                                                   @"middle" : middleMultiplier,
                                                    @"right" : rightMultiplier
                                                    };
    return [horizontalMultiplierDictionary[position] floatValue];
}

-(CGFloat)verticalMultiplierForIndex:(NSUInteger)index {
    NSArray *topArray = @[@0, @1, @2];
    NSArray *middleTopArray = @[@3, @4, @5];
    NSArray *middleBottomArray = @[@6, @7, @8];
//    NSArray *bottomArray = @[@9, @10, @11];
    
    NSString *position;
    
    if ([topArray containsObject:[NSNumber numberWithUnsignedInteger:index]]) {
        position = @"top";
    } else if ([middleTopArray containsObject:[NSNumber numberWithUnsignedInteger:index]]){
        position = @"middleTop";
    } else if ([middleBottomArray containsObject:[NSNumber numberWithUnsignedInteger:index]]){
        position = @"middleBottom";
    } else {
        position = @"bottom";
    }
    
    NSNumber *topMultiplier = @0.3;
    NSNumber *middleTopMultiplier = @0.75;
    NSNumber *middleBottomMultiplier = @1.22;
    NSNumber *bottomMultiplier = @1.7;
    
    NSDictionary *verticalMultiplierDictionary = @{
                                                   @"top" : topMultiplier,
                                                   @"middleTop" : middleTopMultiplier,
                                                   @"middleBottom" : middleBottomMultiplier,
                                                   @"bottom" : bottomMultiplier
                                                   };
    return [verticalMultiplierDictionary[position] floatValue];
}

@end

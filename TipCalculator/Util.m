//
//  Util.m
//  TipCalculator
//
//  Created by Charlie Massry on 3/27/15.
//  Copyright (c) 2015 Charlie Massry. All rights reserved.
//

#import "Util.h"

@implementation Util
+(UIColor *)opaqueColorWithOpacity:(CGFloat)alpha {
    return [[UIColor alloc] initWithRed:1.0
                                  green:1.0
                                   blue:1.0
                                  alpha:alpha];
}

+(NSArray *)buttonFaces {
    return @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"C", @"0", @"."];
}

@end

//
//  ToDo.m
//  Deprocrastinator
//
//  Created by Ronald Hernandez on 3/17/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "ToDo.h"

@implementation ToDo


-(instancetype)initWithActionItem:(NSString *)item andWithDecider:(int)decider{
    self = [super init];
    self.actionItem = item;
    self.colorDecider = decider;

    return self;
}

@end

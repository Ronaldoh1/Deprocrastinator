//
//  ToDo.h
//  Deprocrastinator
//
//  Created by Ronald Hernandez on 3/17/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property NSString *actionItem;
@property int colorDecider;

-(instancetype)initWithActionItem:(NSString *)item andWithDecider:(int)decider;

@end

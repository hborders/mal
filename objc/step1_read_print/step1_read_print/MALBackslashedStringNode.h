//
//  MALBackslashedStringNode.h
//  step1_read_print
//
//  Created by Heath Borders on 11/12/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MALContainerNode.h"

@interface MALBackslashedStringNode : NSObject<MALContainerNode>

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode;

@end

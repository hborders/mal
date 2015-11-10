//
//  MALConsNode.h
//  step1_read_print
//
//  Created by Heath Borders on 11/9/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MALContainerNode.h"

@class MALLiteralNode;

@interface MALConsNode : NSObject<MALContainerNode>

- (nonnull instancetype)init;
- (nonnull instancetype)initWithParentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode;

- (void)appendLiteralNode:(nonnull MALLiteralNode *)literalNode;

@end

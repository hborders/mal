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

typedef NS_ENUM(NSInteger, MALConsNodeType) {
    MALConsNodeTypeList,
    MALConsNodeTypeVector,
};

@interface MALConsNode : NSObject<MALContainerNode>

- (nonnull instancetype)init;
- (nonnull instancetype)initWithType:(MALConsNodeType)type
                 parentContainerNode:(nonnull id<MALContainerNode>)parentContainerNode;

- (void)appendLiteralNode:(nonnull MALLiteralNode *)literalNode;

@end

//
//  main.m
//  step0_repl
//
//  Created by Heath Borders on 11/9/15.
//  Copyright © 2015 Heath Borders. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSFileHandle *inputFileHandle = [NSFileHandle fileHandleWithStandardInput];
        
        while (true) {
            printf("user> ");
            fflush(stdout);
            
            NSData *inputData = [inputFileHandle availableData];
            NSString *inputString = [[[NSString alloc] initWithData: inputData encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet: [NSCharacterSet newlineCharacterSet]];
            
            printf("%s\n", [inputString cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }
    return 0;
}

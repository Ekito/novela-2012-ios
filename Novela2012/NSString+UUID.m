//
//  NSString+UUID.m
//  Novela2012
//
//  Created by Mélanie Bessagnet on 21/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import "NSString+UUID.h"

@implementation NSString (UUID)

// Code from Ole Begemann http://oleb.net/blog/2011/09/how-to-replace-the-udid/
+ (NSString *)uuid
{
    NSString *uuidString = nil;
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    if (uuid) {
        uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
    }
    return uuidString;
}

@end

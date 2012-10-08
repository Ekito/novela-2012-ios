//
//  NovelaLocation.m
//  Novela2012
//
//  Created by Mélanie Bessagnet on 28/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import "NovelaLocation.h"

@implementation NovelaLocation

@synthesize latitude, longitude, userId, isStart, zoom;

- (id)init {
	self = [super init];
	if (self == nil) {
		return nil;
	}
	return self;
}

@end

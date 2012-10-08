//
//  NovelaWSFacade.h
//  Novela2012
//
//  Created by Mélanie Bessagnet on 28/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NovelaLocation.h"

@interface NovelaWSFacade : NSObject

+ (NovelaWSFacade *)sharedNovelaWSFacade;
- (void)addLocation:(NovelaLocation *)location completion:(void (^)(BOOL finished))block;
- (void)centerMapOnLocation:(NovelaLocation *)location completion:(void (^)(BOOL finished))block;

@end

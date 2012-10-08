//
//  NovelaLocation.h
//  Novela2012
//
//  Created by Mélanie Bessagnet on 28/09/12.
//  Copyright (c) 2012 ekito. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NovelaLocation : NSObject

@property (nonatomic, strong)   NSString    *latitude;
@property (nonatomic, strong)   NSString    *longitude;
@property (nonatomic, strong)   NSString    *userId;
@property (nonatomic, strong)   NSString    *zoom;
@property (nonatomic)           BOOL        isStart;

@end

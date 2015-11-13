//
//  AppDelegate.h
//  DRugsReminder
//
//  Created by DrugsReminder on 25/02/2015.
//  Copyright (c) 2015 DrugsReminder. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) EventManager *eventManager;


@end


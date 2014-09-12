//
//  PageViewController.h
//  PageApp
//
//  Created by Bin Liu on 9/12/14.
//  Copyright (c) 2014 Bin Liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageViewController : UIViewController <UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageController;
- (IBAction)First:(id)sender;
- (IBAction)Second:(id)sender;
- (IBAction)Third:(id)sender;
- (IBAction)Four:(id)sender;


@end

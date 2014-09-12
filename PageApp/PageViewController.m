//
//  PageViewController.m
//  PageApp
//
//  Created by Bin Liu on 9/12/14.
//  Copyright (c) 2014 Bin Liu. All rights reserved.
//

#import "PageViewController.h"
#import "APPChildViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    CGRect frame =[[self view] bounds];
    frame.size.height -=30;
    [[self.pageController view] setFrame:frame];
    
    APPChildViewController *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(APPChildViewController *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(APPChildViewController *)viewController index];
    
    
    index++;
    
    if (index == 5) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (APPChildViewController *)viewControllerAtIndex:(NSUInteger)index {
    
    APPChildViewController *childViewController = [[APPChildViewController alloc] initWithNibName:@"APPChildViewController" bundle:nil];
    childViewController.index = index;
    
    return childViewController;
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

-(void) switchToIndex:(NSUInteger)index
{
    APPChildViewController* viewController =  [self viewControllerAtIndex:index];
    __weak UIViewController *weakViewController = viewController;
    __weak UIPageViewController *weakPageController = self.pageController;
    if(viewController)
	{
        if(index == 4)weakViewController = nil;
        
        APPChildViewController* currentViewController = self.pageController.viewControllers[0];
        NSUInteger currViewIndex = currentViewController.index;
        [self.pageController setViewControllers:@[viewController]
                                      direction:currViewIndex < index ? UIPageViewControllerNavigationDirectionForward : UIPageViewControllerNavigationDirectionReverse
                                       animated:YES
                                     completion:^(BOOL finished)
		 {
			 if (weakPageController)
			 {
				 dispatch_async(dispatch_get_main_queue(), ^
								{
									[weakPageController setViewControllers:@[weakViewController]
																 direction:UIPageViewControllerNavigationDirectionReverse
																  animated:NO completion: nil
									 ];
								});
			 }
		 }];
        
    }
}

- (IBAction)First:(id)sender {
    [self switchToIndex:1];
}



- (IBAction)Second:(id)sender {
    [self switchToIndex:2];
}

- (IBAction)Third:(id)sender {
    [self switchToIndex:3];
}

- (IBAction)Four:(id)sender {
    [self switchToIndex:4];
}
@end

//
//  DetailViewController.h
//  W5D1 - AVPlayerViewController
//
//  Created by Daniel Mathews on 2015-06-01.
//  Copyright (c) 2015 ca.lighthouselabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end


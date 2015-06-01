//
//  TableViewCell.h
//  W5D1 - AVPlayerViewController
//
//  Created by Daniel Mathews on 2015-06-01.
//  Copyright (c) 2015 ca.lighthouselabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabe;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailImageView;

@end

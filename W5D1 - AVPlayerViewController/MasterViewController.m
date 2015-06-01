//  MasterViewController.m
//  W5D1 - AVPlayerViewController
//
//  Created by Daniel Mathews on 2015-06-01.
//  Copyright (c) 2015 ca.lighthouselabs. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import <Photos/Photos.h>
#import "TableViewCell.h"
#import "MyAVPlayerViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@property PHFetchResult *results;
@property PHImageManager *imageManager;

@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.results = [PHAsset fetchAssetsWithMediaType:PHAssetMediaTypeVideo options:nil];
    self.imageManager = [PHImageManager defaultManager];

//    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
//    self.navigationItem.rightBarButtonItem = addButton;
//    

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showPlayer"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
       
        PHAsset *object = self.results[indexPath.row];
        MyAVPlayerViewController *playerController = segue.destinationViewController;

        [self.imageManager requestPlayerItemForVideo:object options:nil resultHandler:^(AVPlayerItem *playerItem, NSDictionary *info) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                playerController.player = [AVPlayer playerWithPlayerItem:playerItem];
            });
        }];
        
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    PHAsset *object = self.results[indexPath.row];
    
    [self.imageManager requestImageForAsset:object targetSize:CGSizeMake(200, 200) contentMode:PHImageContentModeAspectFit options:nil resultHandler:^(UIImage *result, NSDictionary *info) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.thumbnailImageView.image = result;
        });
        
    }];
    
    cell.titleLabe.text = [object description];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end

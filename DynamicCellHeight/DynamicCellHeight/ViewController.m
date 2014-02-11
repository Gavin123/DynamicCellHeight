//
//  ViewController.m
//  DynamicCellHeight
//
//  Created by Shinren Pan on 2014/2/11.
//  Copyright (c) 2014年 Shinren Pan. All rights reserved.
//

#import "MyCell.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINib *cellNib = [UINib nibWithNibName:@"MyCell" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"MyCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellForTableView:tableView AtIndexPath:indexPath];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [self cellForTableView:tableView AtIndexPath:indexPath];
    
    [cell.contentView setNeedsLayout];
    [cell.contentView layoutIfNeeded];

    CGSize size = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    
    // why add 1, because size is cell.contentView' size
    return size.height + 1;
}

- (MyCell *)cellForTableView:(UITableView *)tableView AtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    
    if(indexPath.row %2 == 0)
    {
        cell.title.text = @"Hello World";
    }
    else
    {
        cell.title.text = @"Hello World, Hello World, Hello World, Hello World, Hello Word2";
    }
    
    return cell;
}

@end

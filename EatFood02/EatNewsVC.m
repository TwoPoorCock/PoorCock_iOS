//
//  EatNewsVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/24.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "EatNewsVC.h"
#import "EatNewsCell.h"
#import "NewsWebVC.h"

@interface EatNewsVC ()

@end

@implementation EatNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小鳄食讯";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"NewsCell";
    EatNewsCell *cell = (EatNewsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        UINib *nib=[UINib nibWithNibName:@"EatNewsCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        cell = (EatNewsCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    if(indexPath.section==0)//第一个分区
    {
        if(indexPath.row==0)
        {
            cell.newsTitle.text = @"老将军绥远什锦火锅";
            cell.newsText.text = @"来自学长的冬季温暖、好吃又实惠";
            cell.newsImage.image = [UIImage imageNamed:@"小鳄吃饭"];
        }
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NewsWebVC* newswebVC = [[NewsWebVC alloc] init];
    
    if(indexPath.section==0)//第一个分区
    {
        if(indexPath.row==0)
        {
            self.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:newswebVC animated:YES];
            self.hidesBottomBarWhenPushed=NO;
        }
    }
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

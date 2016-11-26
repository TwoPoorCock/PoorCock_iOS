//
//  EatMenuVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/11/24.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "EatMenuVC.h"
#import "EatMenuCell.h"

@interface EatMenuVC ()

@end

@implementation EatMenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"小鳄菜单";
    
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
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    NSString *cellIdentifier = @"MenuCell";
    EatMenuCell *cell = (EatMenuCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        UINib *nib=[UINib nibWithNibName:@"EatMenuCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        cell = (EatMenuCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }

    if(indexPath.section==0)//第一个分区
    {
        if(indexPath.row==0)
        {
            [cell addbackground:[UIImage imageNamed:@"内蒙古财经大学"] andname:@"内蒙古财经大学食堂菜单"];
        }
        if(indexPath.row==1)
        {
            [cell addbackground:[UIImage imageNamed:@"menu_background01"] andname:@"小鳄喜爱的菜单"];
        }
        if(indexPath.row==2)
        {
            [cell addbackground:[UIImage imageNamed:@"menu_background02"] andname:@"小鳄的历史菜单"];
        }
    }

    return cell;
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

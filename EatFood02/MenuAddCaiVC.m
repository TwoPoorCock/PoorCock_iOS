//
//  MenuAddCaiVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/12/20.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "MenuAddCaiVC.h"

@interface MenuAddCaiVC ()
@property (weak, nonatomic) IBOutlet UITextField *caiName;

@property (weak, nonatomic) IBOutlet UISegmentedControl *caiHot;

@property (weak, nonatomic) IBOutlet UISegmentedControl *caiMeat;
@end

@implementation MenuAddCaiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"添加菜品";
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(saveCai)];
    
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) saveCai {
    //plist文件解档
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"PersonLove.plist"];
    NSArray *arr = [NSArray arrayWithContentsOfFile:filePath];
    if(arr==nil){
        arr = [[NSArray alloc] init];
    }
    NSMutableArray *myMutableArray = [arr mutableCopy];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:
                          _caiName.text, @"dishname",
                          [NSString stringWithFormat: @"%d", _caiHot.selectedSegmentIndex], @"flagH",
                          [NSString stringWithFormat: @"%d", _caiMeat.selectedSegmentIndex], @"flagR",
                          nil];
    [myMutableArray addObject:dic];
    NSLog(@"%@", myMutableArray);
    NSArray *myArray = [myMutableArray copy];
    
    //plist文件归档
    [myArray writeToFile:filePath atomically:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
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

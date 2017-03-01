//
//  MenuVC.m
//  EatFood02
//
//  Created by 郝宇泽 on 2016/12/20.
//  Copyright © 2016年 twopoorcick. All rights reserved.
//

#import "MenuVC.h"
#import "MenuAddCaiVC.h"
#import "MJRefresh.h"
#import "HttpTool.h"

@interface MenuVC ()

@property (strong, nonatomic) NSString *path;
@property (strong, nonatomic) NSString *filePath;
@property (strong, nonatomic) NSArray *arr;
@property (strong, nonatomic) NSArray *resultDic;
@end

@implementation MenuVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.menuType==0){
        self.navigationItem.title = @"内财的菜单";
    }else if(self.menuType==1){
        self.navigationItem.title = @"喜欢的菜单";
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCai)];
        self.navigationItem.rightBarButtonItem = rightButton;
    }else if(self.menuType==2){
        self.navigationItem.title = @"吃过的菜单";
    }

}

- (void) viewWillAppear:(BOOL)animated{
    
    if(self.menuType==0){
        //http网络请求
        [self askForSchhol];
    }else if(self.menuType==1){
        //plist文件解档
        self.path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        self.filePath = [self.path stringByAppendingPathComponent:@"PersonLove.plist"];
        self.arr = [NSArray arrayWithContentsOfFile:self.filePath];
    }else if(self.menuType==2){
        //plist文件解档
        self.path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        self.filePath = [self.path stringByAppendingPathComponent:@"HistoryMenu.plist"];
        self.arr = [NSArray arrayWithContentsOfFile:self.filePath];
    }
    
    
    [self.tableView reloadData];
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
    if(self.menuType==0){
        return [self.resultDic count];
    }else{
        return [self.arr count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"CaiCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(self.menuType==0){
        //校园菜单菜品排列
        cell.imageView.image = [UIImage imageNamed:@"透明E"];
        cell.textLabel.text = [self.resultDic[indexPath.row] objectForKey:@"dishname"];
    }else if(self.menuType==1){
        //喜欢的菜单菜品排列
        cell.imageView.image = [UIImage imageNamed:@"透明E"];
        cell.textLabel.text = [self.arr[indexPath.row] objectForKey:@"cainame"];
    }else if(self.menuType==2){
        //历史的菜单菜品倒叙排列
        cell.imageView.image = [UIImage imageNamed:@"透明E"];
        cell.textLabel.text = [self.arr[[self.arr count]-indexPath.row-1] objectForKey:@"cainame"];
    }
    
    return cell;
}

- (void) addCai{
    //修改下一个界面的返回键
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
    UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuAddCaiVC* addCai = [secondStoryBoard instantiateViewControllerWithIdentifier:@"menuaddcaivc"];
    
    //隐藏底部工具栏
    self.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:addCai animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

//校园菜单网络请求
- (void) askForSchhol{
    NSString* url = @"http://123.57.64.99/poolman/app/menu/getSystemMenuList";
    //创建一个可变字典
    NSMutableDictionary *parametersDic = [NSMutableDictionary dictionary];
    //往字典里面添加需要提交的参数
    [parametersDic setObject:@"0" forKey:@"pageNo"];
    [parametersDic setObject:@"4" forKey:@"pageSize"];
    
    [[HttpTool HttpManager] GET:url parameters:parametersDic progress:nil success:^(NSURLSessionTask *operation, id responseObject) {
        //json解析
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"---获取到的json格式的字典--%@",resultDic);
        
        self.resultDic = resultDic[@"data"][@"Find"];
        NSLog(@"200");
        NSLog(@"%@",[self.resultDic[0] objectForKey:@"dishname"]);
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
    }];
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

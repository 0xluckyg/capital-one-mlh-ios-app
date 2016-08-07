//
//  Menu.m
//  Wanto
//
//  Created by Scott Cho on 8/6/16.
//  Copyright © 2016 Scott Cho. All rights reserved.
//

#import "Menu.h"
#import <CoreLocation/CoreLocation.h>

@interface Menu ()

@end

@implementation Menu

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initializeDesign];
    
    rowNum = [self.menuData.menuDataArray count];
}

- (void)initializeDesign {
    self.menuData = [[MenuData alloc] init];
    self.UIPrinciple = [[UIPrinciple alloc] init];
    
    self.tableView.backgroundColor = self.UIPrinciple.defaultOrange;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    [self.navigationController.navigationBar setBarTintColor:self.UIPrinciple.defaultOrange];
    
    NSLog(@"%@", self.navigationController.navigationBar);
    
    [self.navigationController.navigationBar setTranslucent:NO];
    
    //Style the navigation bar
    UINavigationItem *navItem= [[UINavigationItem alloc] init];
    navItem.title = @"Menu";
    
    //Style navbar
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [self.UIPrinciple wantoFontWithSize:18], NSFontAttributeName,
                                [UIColor whiteColor], NSForegroundColorAttributeName, nil];
    
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    [self.navigationController.navigationBar setItems:@[navItem]];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return rowNum;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    float height = [[UIScreen mainScreen] bounds].size.height;
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    CGSize navBarSize = self.navigationController.navigationBar.frame.size;
    CGFloat statusBarHeight = MIN(statusBarSize.width, statusBarSize.height);
    CGFloat navBarHeight = MIN(navBarSize.width, navBarSize.height);
    
    return (height-statusBarHeight-navBarHeight)/rowNum;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (cell) {
        
        NSDictionary *menuDictionary = [self.menuData.menuDataArray objectAtIndex:indexPath.row];
        
        NSString *imageName = [menuDictionary objectForKey:kMenuImage];
        cell.cellImage.image = [UIImage imageNamed:imageName];
        
        cell.cellLabel.text = [menuDictionary objectForKey:kMenuName];
        
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UIStoryboard *browseStoryboard = [UIStoryboard storyboardWithName:@"Browse" bundle:nil];
    Browse *browseVC = [browseStoryboard instantiateViewControllerWithIdentifier:@"Browse"];
    
    browseVC.type = [[self.menuData.menuDataArray objectAtIndex:indexPath.row] objectForKey:kMenuName];
    
    [self.navigationController pushViewController:browseVC animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

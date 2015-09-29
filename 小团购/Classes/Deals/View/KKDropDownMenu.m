//
//  KKDropDownMenu.m
//  小团购
//
//  Created by Imanol on 9/29/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKDropDownMenu.h"
#import "KKCategory.h"
#import "KKDropDownMainCell.h"
#import "KKDropDownSubCell.h"

@implementation KKDropDownMenu

+(instancetype)dropDownMenu{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"KKDropDownMenu" owner:nil options:nil]lastObject];
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    
    //self.mainTableView.backgroundColor = [UIColor grayColor];
    self.subTableView.backgroundColor = [UIColor whiteColor];
    
}

#pragma mark - delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(tableView == self.mainTableView){
        
        id<KKDropDownMenuItem> item = self.items[indexPath.row];
        KKDropDownMainCell *cell = [KKDropDownMainCell cellWithTableView:tableView];
        cell.item = item;
        
        return cell;
    }else{
        
        KKDropDownSubCell *cell = [KKDropDownSubCell cellWithTableView:tableView];
        NSInteger mainSelectRow = [self.mainTableView indexPathForSelectedRow].row;
        NSArray *subItems = [self.items[mainSelectRow] subItems];
        cell.textLabel.text = subItems[indexPath.row];
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.subTableView reloadData];
}

#pragma mark - dateSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.mainTableView){
        
        return self.items.count;
    }else{
        
        NSInteger mainSelectRow = [self.mainTableView indexPathForSelectedRow].row;
        NSArray *subItems = [self.items[mainSelectRow] subItems];
        return subItems.count;
    }
}

#pragma mark - 
-(void)setItems:(NSArray *)items{
    
    _items = items;
    [self.mainTableView reloadData];
    [self.subTableView reloadData];
}

@end

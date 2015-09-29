//
//  KKDropDownMenu.m
//  小团购
//
//  Created by Imanol on 9/29/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKDropDownMenu.h"

@implementation KKDropDownMenu

+(instancetype)dropDownMenu{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"KKDropDownMenu" owner:nil options:nil]lastObject];
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    
    //self.mainTableView.backgroundColor = [UIColor grayColor];
    //self.subTableView.backgroundColor = [UIColor blackColor];
    
}

#pragma mark - delegate
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"Main";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if(tableView == self.mainTableView){
        
        cell.textLabel.text = [NSString stringWithFormat:@"main-%ld",(long)indexPath.row];
    }else{
        
        cell.textLabel.text = [NSString stringWithFormat:@"sub-%ld",(long)indexPath.row];
    }
    
    
    return cell;
}

#pragma mark - dateSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if(tableView == self.mainTableView){
        
        return 5;
    }else{
        
        return 10;
    }
}

@end

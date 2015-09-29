//
//  KKDropDownMainCell.m
//  小团购
//
//  Created by Imanol on 9/29/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import "KKDropDownMainCell.h"


@interface KKDropDownMainCell ()

@property(nonatomic, strong)UIImageView *rightArrow;
@end

@implementation KKDropDownMainCell

- (void)awakeFromNib {
    // Initialization code
}

- (UIImageView *)rightArrow
{
    if(_rightArrow == nil){
        self.rightArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_cell_rightArrow"]];
    }
    return _rightArrow;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)cellWithTableView:(UITableView *)tableView{
    
    static NSString *ID = @"main";
    KKDropDownMainCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell){
        
        cell = [[KKDropDownMainCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    return cell;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [UIImage imageNamed:@"bg_dropdown_leftpart"];
        self.backgroundView = bg;
        
        UIImageView *selectedBg = [[UIImageView alloc] init];
        selectedBg.image = [UIImage imageNamed:@"bg_dropdown_left_selected"];
        self.selectedBackgroundView = selectedBg;
    }
    
    return self;
}

-(void)setItem:(id<KKDropDownMenuItem>)item{
    
    _item = item;
    self.textLabel.text = [item title];
    if([item respondsToSelector:@selector(iconName)]){
        self.imageView.image = [UIImage imageNamed:[item iconName]];
    }
    
    if([item respondsToSelector:@selector(iconHighlightedName)]){
        self.imageView.highlightedImage = [UIImage imageNamed:[item iconHighlightedName]];
    }
    
    if([item subItems].count>0){
        
        self.accessoryView = self.rightArrow;
    }else{
        
        self.accessoryView = nil;
    }
  
}

@end

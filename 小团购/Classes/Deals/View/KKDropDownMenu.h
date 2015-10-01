//
//  KKDropDownMenu.h
//  小团购
//
//  Created by Imanol on 9/29/15.
//  Copyright (c) 2015 Imanol. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KKDropDownMenu;
@protocol KKDropDownMenuItem <NSObject>

@required
- (NSString*)title;
- (NSArray *)subItems;
@optional
-(NSString*)iconName;
-(NSString*)iconHighlightedName;
@end

@protocol KKDropDownMenuDelegate <NSObject>

@optional
-(void)dropDownMenu:(KKDropDownMenu*)dpMenu mainRow:(NSInteger)row;
-(void)dropDownMenu:(KKDropDownMenu*)dpMenu subRow:(NSInteger)subRow ofMain:(NSInteger)mainRow;
@end

@interface KKDropDownMenu : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet UITableView *subTableView;
@property (nonatomic , strong) NSArray *items;
@property (nonatomic , weak) id<KKDropDownMenuDelegate> delegate;
+(instancetype)dropDownMenu;
@end

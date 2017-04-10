//
//  TableViewCellForPosition.h
//  yahoo-weather-mirror
//
//  Created by as4 on 17/4/11.
//  Copyright © 2017年 hhxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCellForPosition : UITableViewCell
@property (nonatomic, strong) IBOutlet UIImageView* positionImage;
@property (nonatomic, strong) IBOutlet UILabel* positionName;
@property (nonatomic, strong) IBOutlet UISwitch* close;
@end

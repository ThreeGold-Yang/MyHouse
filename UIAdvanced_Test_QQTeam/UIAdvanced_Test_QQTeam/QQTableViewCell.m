//
//  QQTableViewCell.m
//  UIAdvanced_Test_QQTeam
//
//  Created by lanou on 16/6/23.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "QQTableViewCell.h"

@implementation QQTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        
        self.nameL = [[UILabel alloc]init];
        [self.contentView addSubview:self.nameL];
        
        self.introL = [[UILabel alloc]init];
        [self.contentView addSubview:self.introL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(10, 0, 60, 60);
    [self.imageV.layer setMasksToBounds:YES];
    self.imageV.layer.cornerRadius = 30;
    self.imageV.backgroundColor = [UIColor redColor];
    
    self.nameL.frame = CGRectMake(80, 0, 100, 30);
    self.nameL.font = [UIFont boldSystemFontOfSize:20];
    self.introL.frame = CGRectMake(80, 30, 200, 30);
    self.introL.font = [UIFont boldSystemFontOfSize:15];
    self.introL.alpha = 0.5;
}

-(void)setRowModel:(RowModel *)rowModel
{
    if (_rowModel != rowModel) {
        _rowModel = rowModel;
        self.imageV.image = [UIImage imageNamed:rowModel.icon];
        
        if (rowModel.vip == 1) {
            self.nameL.textColor = [UIColor redColor];
        }
        self.nameL.text = rowModel.name;
        self.introL.text = rowModel.intro;
    }
}


@end

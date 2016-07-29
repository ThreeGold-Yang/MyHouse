//
//  LocalTableViewCell.m
//  Product-A
//
//  Created by lanou on 16/6/30.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import "LocalTableViewCell.h"

@implementation LocalTableViewCell

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
        self.titleL = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleL];
        
        self.imageV = [[UIImageView alloc]init];
        self.imageV.backgroundColor = PKCOLOR(155, 155, 155);
        [self.contentView addSubview:self.imageV];
        
        self.chooseBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
        self.chooseBtn.backgroundColor = [UIColor grayColor];
        //[self.chooseBtn setImage:[UIImage imageNamed:@"me"] forState:(UIControlStateNormal)];
        [self.contentView addSubview:self.chooseBtn];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(30, 0, 60, 60);
    self.titleL.frame = CGRectMake(90, 15, 200, 30);
    self.chooseBtn.frame = CGRectMake(5, 20, 20, 20);
    [self.chooseBtn.layer setMasksToBounds:YES];
    self.chooseBtn.layer.cornerRadius = 10;
}

@end

//
//  ReadCollectionViewCell.m
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#define KImageW (kScreenWidth-40)/3
#define KImageH (kScreenHeight-20-KNaviH-200-20-20)/3
#import "ReadCollectionViewCell.h"

@implementation ReadCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageV = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imageV];
        
        self.titleL = [[UILabel alloc]init];
        self.titleL.textColor = PKCOLOR(240, 240, 240);
        self.titleL.font = [UIFont systemFontOfSize:17];
        [self.imageV addSubview:self.titleL];
        
        self.ennameL = [[UILabel alloc]init];
        self.ennameL.textColor = PKCOLOR(240, 240, 240);
        self.ennameL.font = [UIFont systemFontOfSize:15];
        [self.imageV addSubview:self.ennameL];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageV.frame = CGRectMake(0, 0, KImageW, KImageH);
    self.titleL.frame = CGRectMake(0 ,KImageH*4/5 , KImageW*1/2,KImageH/5);
    self.ennameL.frame = CGRectMake(KImageW*1/2, KImageH*4/5 , KImageW/2,KImageH/5);
}

-(void)setCollectionModel:(CollectionModel *)collectionModel1
{
    if (_collectionModel != collectionModel1) {
        _collectionModel = collectionModel1;
        [self.imageV sd_setImageWithURL:[NSURL URLWithString:collectionModel1.coverimg] placeholderImage:placeHoldImageURL completed:nil];
        self.titleL.text = collectionModel1.name;
        
        self.ennameL.text = collectionModel1.enname;
    }
}


@end

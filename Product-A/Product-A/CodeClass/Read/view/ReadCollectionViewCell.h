//
//  ReadCollectionViewCell.h
//  Product-A
//
//  Created by lanou on 16/6/24.
//  Copyright © 2016年 抖腿宅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionModel.h"
@interface ReadCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong) UIImageView *imageV;
@property(nonatomic,strong) UILabel *titleL;
@property(nonatomic,strong) UILabel *ennameL;
@property(nonatomic,strong) CollectionModel *collectionModel;
@end

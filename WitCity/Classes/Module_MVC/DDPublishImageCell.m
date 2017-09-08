//
//  DDPublishImageCell.m
//  WitCity
//
//  Created by 方冬冬 on 16/7/27.
//  Copyright © 2016年 bjxybs. All rights reserved.
//

#import "DDPublishImageCell.h"


@interface DDPublishImageCell()
@property (strong, nonatomic) UICollectionView *myImagesCollectionView;
@property (strong, nonatomic) NSMutableArray *imageViewsDict;
@end

@implementation DDPublishImageCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 初始化代码
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        if (!self.myImagesCollectionView) {
            UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
            self.myImagesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 10, WINDOW_WIDTH-2*15, 80) collectionViewLayout:layout];
            self.myImagesCollectionView.scrollEnabled = NO;
            [self.myImagesCollectionView setBackgroundView:nil];
            [self.myImagesCollectionView setBackgroundColor:[UIColor clearColor]];
            [self.myImagesCollectionView registerClass:[DDPublishImageCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DDPublishImageCollectionViewCell class])];
            self.myImagesCollectionView.dataSource = self;
            self.myImagesCollectionView.delegate = self;
            [self.contentView addSubview:self.myImagesCollectionView];
        }
        if (!_imageViewsDict) {
            _imageViewsDict = [[NSMutableArray alloc] init];
        }
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

//更新列表高度
-(void)setCurUploadImageHelper:(DDUploadImageHelper *)curUploadImageHelper
{
    if (_curUploadImageHelper!=curUploadImageHelper) {
        _curUploadImageHelper=curUploadImageHelper;
    }
    //更新列表高度
    [self.myImagesCollectionView setHeight:[DDPublishImageCell cellHeightWithObj:_curUploadImageHelper]];
    [self.myImagesCollectionView reloadData];
    
    //把为浏览大图做准备
    if (_imageViewsDict) {
        [_imageViewsDict removeAllObjects];
        
        for (NSURL *itemUrl in curUploadImageHelper.selectedAssetURLs) {
            MWPhoto *mwphoto=[MWPhoto photoWithURL:itemUrl];
            mwphoto.caption=nil;
            [_imageViewsDict addObject:mwphoto];
        }
    }
}

+ (CGFloat)cellHeightWithObj:(id)obj
{
    CGFloat cellHeight = 30;
    if ([obj isKindOfClass:[DDUploadImageHelper class]]) {
        DDUploadImageHelper *curUploadImage = (DDUploadImageHelper *)obj;
        NSInteger row;
        if (curUploadImage.imagesArray.count <= 0) {
            row = 0;
            cellHeight+=kPictureHW;
        }else{
            NSInteger curRowImageCount=curUploadImage.imagesArray.count<kupdateMaximumNumberOfImage?curUploadImage.imagesArray.count +1:kupdateMaximumNumberOfImage;
            row = ceilf((float)(curRowImageCount)/3.0);
            cellHeight += ([DDPublishImageCollectionViewCell ccellSize].height +5) *row;
        }
    }
    else
    {
        cellHeight+=kPictureHW;
    }
    return cellHeight;
}


#pragma mark UICollectionViewDataSource, UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger num = self.curUploadImageHelper.imagesArray.count;
    //如果没有大于最大上传数 则显示增加图标
    if (num<kupdateMaximumNumberOfImage) {
        return num+ 1;
    }
    return num;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    DDPublishImageCollectionViewCell *ccell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DDPublishImageCollectionViewCell class]) forIndexPath:indexPath];
    if (indexPath.row < self.curUploadImageHelper.imagesArray.count) {
        DDImageItemModel *curImage = [weakSelf.curUploadImageHelper.imagesArray objectAtIndex:indexPath.row];
        ccell.curImageItem = curImage;
    }else{
        ccell.curImageItem = nil;
    }
    ccell.deleteImageBlock = ^(DDImageItemModel *toDelete){
        if (weakSelf.deleteImageBlock) {
            weakSelf.deleteImageBlock(toDelete);
        }
    };
    return ccell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [DDPublishImageCollectionViewCell ccellSize];
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsZero;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    //区分是增加图片事件还是点浏览大图
    if (indexPath.row == self.curUploadImageHelper.imagesArray.count) {
        if (_addPicturesBlock) {
            _addPicturesBlock();
        }
    }
    else
    {
//        SDPhotoBrowser* photoBrowser =[[SDPhotoBrowser alloc] init];
//        //在这里父图的控件是集合视图。刚开始我加的是self，这样subViews少了，导致数组越界。@author fangdongdong【注意】
//        photoBrowser.sourceImagesContainerView = self.myImagesCollectionView;
//        photoBrowser.delegate = self;
//        photoBrowser.imageCount = self.imageViewsDict.count;
//        photoBrowser.currentImageIndex = (NSInteger)indexPath.row;
//        [photoBrowser show];
        
        //由于SDPhotoBrowser显示本地的图片比较麻烦，而MWPhotoBrowser本地网络都可轻松显示
        MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        browser.displayActionButton = NO;
        browser.displayNavArrows = YES;
        browser.displaySelectionButtons = NO; //选择按钮
        browser.alwaysShowControls = NO;
        browser.zoomPhotosToFill = YES;
        browser.enableGrid = NO;
        browser.startOnGrid = NO;
        browser.enableSwipeToDismiss = YES;
        browser.autoPlayOnAppear = NO;
        [browser setCurrentPhotoIndex:indexPath.row];
        [self.viewController.navigationController pushViewController:browser animated:YES];
    }
}

#pragma mark--MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.imageViewsDict.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.imageViewsDict.count) {
        return [self.imageViewsDict objectAtIndex:index];
    }
    return nil;
}

//
//#pragma mark SDPhotoBrowserDelegate
//-(UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index{
//    return [UIImage imageNamed:@"placeHolder.jpg"];
//}
//- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
//{
//    return [self.imageViewsDict objectAtIndex:index];
//}


@end









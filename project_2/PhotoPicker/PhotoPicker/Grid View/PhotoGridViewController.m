//
//  PhotoGridViewController.m
//  PhotoPicker
//
//  Created by Paul Weatherby on 2/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "PhotoGridViewController.h"

@interface PhotoGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) PhotoLibrary* photoLib;

@property (weak, nonatomic) IBOutlet UICollectionView *photoCollection;

@property (weak, nonatomic) IBOutlet UILabel *photoTitleLabel;

@end

@implementation PhotoGridViewController

#pragma mark - ViewController Setup
- (void) viewDidLoad
{
    self.photoTitleLabel.text = @"Tap an Image";
    [super viewDidLoad];
}

- (PhotoLibrary*) photoLib{
    if(!_photoLib)
    {
        _photoLib = [[PhotoLibrary alloc] init];
    }
    return _photoLib;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.photoLib numberOfCategories];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return [self.photoLib numberOfPhotosInCategory:section];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell* newCell = [self.photoCollection dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell"
                                                                                        forIndexPath:indexPath];
    newCell.displayImg.image = [self.photoLib imageForPhotoInCategory:indexPath.section
                                                           atPosition:indexPath.item];
    return newCell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    PhotoCategoryReusableView* newCell = [self.photoCollection dequeueReusableSupplementaryViewOfKind:kind
                                                                                 withReuseIdentifier:@"PhotoCategoryReusableView"
                                                                                        forIndexPath:indexPath];
    newCell.CategoryTitle.text = [self.photoLib nameForCategory:indexPath.section];
    return newCell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.photoTitleLabel.text = [self.photoLib nameForPhotoInCategory:indexPath.section atPosition:indexPath.item];
}


@end

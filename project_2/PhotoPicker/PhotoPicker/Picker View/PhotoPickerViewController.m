//
//  PhotoPickerViewController.m
//  PhotoPicker
//
//  Created by Paul Weatherby on 2/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "PhotoPickerViewController.h"

@interface PhotoPickerViewController() <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView* displayImg;
@property (weak, nonatomic) IBOutlet UISlider* opacitySlider;

- (IBAction)valueChanged:(UISlider*)sender;

@property (strong, nonatomic) PhotoLibrary* photoLib;
@property NSInteger currentCategory;

@end

@implementation PhotoPickerViewController

- (IBAction)valueChanged:(UISlider*)sender {
    [self.displayImg setAlpha: sender.value];
}

#pragma mark - ViewController Setup
- (void) viewDidLoad{
    if(self.displayImg)
    {
        self.displayImg.image = [self.photoLib imageForPhotoInCategory:0 atPosition:0];
    }
    self.currentCategory = 0;
    if(self.opacitySlider)
    {
        self.opacitySlider.value = 1.0;
    }
    [super viewDidLoad];
}

- (PhotoLibrary*) photoLib{
    if(!_photoLib)
    {
        _photoLib = [[PhotoLibrary alloc] init];
    }
    return _photoLib;
}


#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView*)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView*)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0)
    {
        return [self.photoLib numberOfCategories];
    }
    else
    {
        return [self.photoLib numberOfPhotosInCategory:self.currentCategory];
    }
}

- (NSString*)pickerView:(UIPickerView*)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component == 0)
    {
        return [self.photoLib nameForCategory:row];
    }
    else
    {
        return [self.photoLib nameForPhotoInCategory:self.currentCategory atPosition:row];
    }
}


#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView*)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if( component == 0)
    {
        self.currentCategory = row;
        self.displayImg.image = [self.photoLib imageForPhotoInCategory:self.currentCategory atPosition:0];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:true];
    }
    else
    {
        self.displayImg.image = [self.photoLib imageForPhotoInCategory:self.currentCategory atPosition:row];
    }
}

@end


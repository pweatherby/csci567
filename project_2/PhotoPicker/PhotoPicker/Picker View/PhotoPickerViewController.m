//
//  PhotoPickerViewController.m
//  PhotoPicker
//
//  Created by Paul Weatherby on 2/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "PhotoPickerViewController.h"

@interface PhotoPickerViewController()

@property NSInteger currentCategory;
@end

@implementation PhotoPickerViewController

- (IBAction)valueChanged:(UISlider *)sender {
    [self.displayImg setAlpha: sender.value];
}

- (PhotoLibrary*) lib{
    if(!_lib)
    {
        _lib = [[PhotoLibrary alloc] init];
    }
    return _lib;
}

// DataSource Functions

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0)
    {
        return [self.lib numberOfCategories];
    }else{
        return [self.lib numberOfPhotosInCategory:self.currentCategory];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component == 0)
    {
        return [self.lib nameForCategory:row];
    }
    else
    {
        return [self.lib nameForPhotoInCategory:self.currentCategory atPosition:row];
    }
}


// Delegate Functions

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"selecting: row[%@] component[%@]", [NSString stringWithFormat:@"%d", row], [NSString stringWithFormat:@"%d", component]);
    if( component == 0)
    {
        self.currentCategory = row;
        self.displayImg.image = [self.lib imageForPhotoInCategory:self.currentCategory atPosition:0];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:true];
    }else
    {
        self.displayImg.image = [self.lib imageForPhotoInCategory:self.currentCategory atPosition:row];
    }
}


// ViewController Functions

- (void) viewDidLoad{
    self.displayImg.image = [self.lib imageForPhotoInCategory:0 atPosition:0];
    self.currentCategory = 0;
    [super viewDidLoad];
}

@end


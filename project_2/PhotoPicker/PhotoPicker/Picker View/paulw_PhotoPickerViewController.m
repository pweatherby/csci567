//
//  paulw_PhotoPickerViewController.m
//  PhotoPicker
//
//  Created by Paul Weatherby on 2/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "paulw_PhotoPickerViewController.h"

@interface paulw_PhotoPickerViewController()


@end

@implementation paulw_PhotoPickerViewController

- (IBAction)valueChanged:(UISlider *)sender {
    [self.displayImg setAlpha: sender.value];
}

- (paulw_PhotoLibrary*) lib{
    if(!_lib)
    {
        _lib = [[paulw_PhotoLibrary alloc] init];
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
        return [self.lib numberOfPhotosInCategory:component];
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(component == 0)
    {
        return [self.lib nameForCategory:row];
    }
    else
    {
        return [self.lib nameForPhotoInCategory:component atPosition:row];
    }
}


// Delegate Functions

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"selecting: row[", row, @"]com[", component, @"]");
    if( component == 0)
    {
        self.displayImg.image = [self.lib imageForPhotoInCategory:row atPosition:0];
    }else
    {
        self.displayImg.image = [self.lib imageForPhotoInCategory:component atPosition:row];
    }
}


- (void) viewDidLoad{
    self.displayImg.image = [self.lib imageForPhotoInCategory:0 atPosition:0];
    
    [super viewDidLoad];
}

@end


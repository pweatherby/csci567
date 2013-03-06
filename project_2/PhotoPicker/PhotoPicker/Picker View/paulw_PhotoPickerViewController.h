//
//  paulw_PhotoPickerViewController.h
//  PhotoPicker
//
//  Created by Paul Weatherby on 2/28/13.
//  Copyright (c) 2013 Paul Weatherby. All rights reserved.
//

#import "paulw_PhotoLibrary.h"

@interface paulw_PhotoPickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *displayImg;

- (IBAction)valueChanged:(UISlider *)sender;

@property (nonatomic) paulw_PhotoLibrary *lib;


@end

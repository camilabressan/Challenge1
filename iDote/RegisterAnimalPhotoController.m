//
//  RegisterAnimalPhotoController.m
//  iDote
//
//  Created by Jonathan Andrade on 23/03/15.
//  Copyright (c) 2015 Bepid. All rights reserved.
//

#import "RegisterAnimalPhotoController.h"

@implementation RegisterAnimalPhotoController
- (IBAction)backFromRegisterAnimal:(UIStoryboardSegue *)segue {
    
}

- (void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [_mainImage setBackgroundImage:image forState:UIControlStateNormal];
    [_mainImage setTitle:@"" forState:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setFirstImage:(id)sender {
    
    UIImagePickerController *imagePickerControllerMain = [[UIImagePickerController alloc] init];
    imagePickerControllerMain.modalPresentationStyle = UIModalPresentationCurrentContext;
    imagePickerControllerMain.delegate = self;
    
    [self presentViewController:imagePickerControllerMain animated:NO completion:nil];
}

@end

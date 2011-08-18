//
//  SimpleColorChooserViewController.h
//  SimpleColorChooser
//
//  Created by Dominik Wei-Fieg on 17.08.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleColorChooserViewController : UIViewController {
    UIView *color1;
    UIView *color2;
    UIView *color3;
    UIView *color4;
}

@property (nonatomic, retain) IBOutlet UIView *color1;
@property (nonatomic, retain) IBOutlet UIView *color2;
@property (nonatomic, retain) IBOutlet UIView *color3;
@property (nonatomic, retain) IBOutlet UIView *color4;
- (IBAction)chooseColor1:(id)sender;
- (IBAction)chooseColor2:(id)sender;
- (IBAction)chooseColor3:(id)sender;
- (IBAction)chooseColor4:(id)sender;

@end

//
//  SimpleColorChooserViewController.h
//  SimpleColorChooser
//
//  Created by Dominik Wei-Fieg on 17.08.11.
//  Copyright 2011 Ars Subtilior. All rights reserved.
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and 
//    associated documentation files (the "Software"), to deal in the Software without restriction, 
//    including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
//    and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, 
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all copies or substantial 
//    portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT 
//    LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN 
//    NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, 
//    WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
//    SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.


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

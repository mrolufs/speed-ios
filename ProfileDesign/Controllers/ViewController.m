//
//  ViewController.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/5/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "ViewController.h"
#import "LLModalPickerView.h"

@interface ViewController () <UITextFieldDelegate, UIPickerViewDelegate>
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UITextField *activeField;
@property (strong, nonatomic) IBOutlet UILabel *frameStackLabel;
@property (strong, nonatomic) IBOutlet UILabel *frameReachLabel;
@property (strong, nonatomic) IBOutlet UILabel *armRestStackLabel;
@property (strong, nonatomic) IBOutlet UILabel *armRestReachLabel;
@property (strong, nonatomic) IBOutlet UILabel *stemAngleLabel;
@property (strong, nonatomic) IBOutlet UILabel *stemLengthLabel;
@property (strong, nonatomic) IBOutlet UILabel *spacersLabel;
@property (strong, nonatomic) IBOutlet UILabel *headsetCapLabel;
@property (strong, nonatomic) IBOutlet UITextField *frameStack;
@property (strong, nonatomic) IBOutlet UITextField *frameReach;
@property (strong, nonatomic) IBOutlet UITextField *armRestStack;
@property (strong, nonatomic) IBOutlet UITextField *armRestReach;
@property (strong, nonatomic) IBOutlet UITextField *stemAngle;
@property (strong, nonatomic) IBOutlet UITextField *stemLength;
@property (strong, nonatomic) IBOutlet UITextField *spacers;
@property (strong, nonatomic) IBOutlet UITextField *headsetCap;
@property (strong, nonatomic) IBOutlet UIButton *backgroundButton;


@property (nonatomic, assign) BOOL moveFormField;

@property (nonatomic, strong) NSArray *bikeFrameStackChoices;
@property (nonatomic, strong) NSArray *bikeFrameReachChoices;
@property (nonatomic, strong) NSArray *armRestStackChoices;
@property (nonatomic, strong) NSArray *armRestReachChoices;
@property (nonatomic, strong) NSArray *stemAngleChoices;
@property (nonatomic, strong) NSArray *stemLengthChoices;
@property (nonatomic, strong) NSArray *spacersChoices;
@property (nonatomic, strong) NSArray *headsetCapChoices;


-(IBAction)goNextField:(id)sender;
@end


@implementation ViewController

@synthesize activeField;

- (void)viewDidLoad
{
    [super viewDidLoad];
	//[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController setNavigationBarHidden:YES];
    
    // SET FORM FIELD ACTIONS
    [self setupUI];
    
    // SETUP PICKER FIELD CHOICES
    [self setupPickerChoices];
    
    // SET KEYBOARD NOTIFICATIONS
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

-(void)viewWillDisappear:(BOOL)animated
{
    // REMOVE KEYBOARD NOTIFICATIONS
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:self.view.window];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:self.view.window];
}

-(void)setupUI
{
    // SET FIELD ACTIONS
    [_frameStack addTarget:self
                    action:@selector(goNextField:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    [_frameReach addTarget:self
                    action:@selector(goNextField:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    [_armRestStack addTarget:self
                    action:@selector(goNextField:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    [_armRestReach addTarget:self
                    action:@selector(goNextField:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    [_stemAngle addTarget:self
                    action:@selector(goNextField:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    [_stemLength addTarget:self
                   action:@selector(goNextField:)
         forControlEvents:UIControlEventEditingDidEndOnExit];
    [_spacers addTarget:self
                    action:@selector(goNextField:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    [_headsetCap addTarget:self
                 action:@selector(goNextField:)
       forControlEvents:UIControlEventEditingDidEndOnExit];
    
    // SET DEFAULT VALUES FOR EACH TEXT FIELD
//    [_frameStack setText:@"Choice One"];
//    [_frameReach setText:@"Choice One"];
//    [_armRestStack setText:@"Choice One"];
//    [_armRestReach setText:@"Choice One"];
    [_stemAngle setText:@"0"];
    [_stemLength setText:@"60"];
    [_spacers setText:@"0.0"];
    [_headsetCap setText:@"0"];
    
    // SET EACH FIELD DELEGATE
    [_frameStack setDelegate:self];
    [_frameReach setDelegate:self];
    [_armRestStack setDelegate:self];
    [_armRestReach setDelegate:self];
    [_stemAngle setDelegate:self];
    [_stemLength setDelegate:self];
    [_spacers setDelegate:self];
    [_headsetCap setDelegate:self];


    // MAKE THE FRAME STACK FIELD FIRST RESPONDER
    //[_frameStack becomeFirstResponder];
    
    
    // SET SCROLLVIEW SIZE
    CGSize contentScrollSize = CGSizeMake(320.0f, 1024.0f);
    CGPoint contentOffsetSize = CGPointMake(0.0f, 0.0f);
    [_scrollView setContentSize:contentScrollSize];
    [_scrollView setContentOffset:contentOffsetSize];
}

-(void)setupPickerChoices
{
    _bikeFrameStackChoices = @[@"Choice One",@"Choice Two",@"Choice Three"];
    _bikeFrameReachChoices = @[@"Choice One",@"Choice Two",@"Choice Three"];
    _armRestStackChoices = @[@"Choice One",@"Choice Two",@"Choice Three"];
    _armRestReachChoices = @[@"Choice One",@"Choice Two",@"Choice Three"];
    _stemAngleChoices = @[@"-25",@"-17",@"-12",@"-10",@"-7",@"-6",@"0",@"6",@"7",@"10",@"12",@"17",@"25"];
    _stemLengthChoices = @[@"60",@"70",@"80",@"90",@"100",@"110",@"120",@"130"];
    _spacersChoices = @[@"0.0",@"2.5",@"5.0",@"7.5",@"10.0",@"12.5",@"15.0",@"17.5",@"20.0",@"22.5",@"25.0",@"27.5",@"30.0",@"32.5",@"35.0",@"37.5",@"40.0"];
    _headsetCapChoices = @[@"0",@"5",@"10",@"15",@"20"];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goNextField:(id)sender
{
    if (sender == _frameStack)
        [_frameReach becomeFirstResponder];
    else if (sender == _frameReach)
        [_armRestStack becomeFirstResponder];
    else if (sender == _armRestStack)
        [_armRestReach becomeFirstResponder];
    else if (sender == _armRestReach)
        [_stemAngle becomeFirstResponder];
    else if (sender == _stemAngle)
        [_stemLength becomeFirstResponder];
    else if (sender == _stemLength)
        [_spacers becomeFirstResponder];
    else if (sender == _spacers)
        [_headsetCap becomeFirstResponder];
    else if (sender == _headsetCap)
        [_headsetCap resignFirstResponder];
    else
        [_frameStack becomeFirstResponder];
}

-(IBAction)resignAllFields:(id)sender
{
    [self.view endEditing:YES];
}

- (void)keyboardWillHide:(NSNotification *)n
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollView.contentInset = contentInsets;
    _scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    NSDictionary* info = [n userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = activeField.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [activeField.superview setFrame:bkgndRect];
    if (_moveFormField)
        NSLog(@"stem angle");
    //[self.scrollView setContentOffset:CGPointMake(0.0, activeField.frame.origin.y-kbSize.height) animated:YES];
    
//    NSDictionary* info = [n userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    self.scrollView.contentInset = contentInsets;
//    self.scrollView.scrollIndicatorInsets = contentInsets;
//    
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your app might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
//        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
//    }
}

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _stemAngle)
    {
        
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_stemAngleChoices];
        [pickerView setSelectedValue:_stemAngle.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            [_stemAngle setText:pickerView.selectedValue];
        }];
        return NO;
        
    } else if (textField == _stemLength) {
        
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_stemLengthChoices];
        [pickerView setSelectedValue:_stemLength.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            [_stemLength setText:pickerView.selectedValue];
        }];
        return NO;
        
    } else if (textField == _spacers) {
        
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_spacersChoices];
        [pickerView setSelectedValue:_spacers.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            [_spacers setText:pickerView.selectedValue];
        }];
        return NO;
        
    } else if (textField == _headsetCap) {
        
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_headsetCapChoices];
        [pickerView setSelectedValue:_headsetCap.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            [_headsetCap setText:pickerView.selectedValue];
        }];
        return NO;
        
    } else
        return YES;
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _stemAngle)
        _moveFormField = YES;
    else if(textField == _stemLength)
        _moveFormField = YES;
    else if(textField == _spacers)
        _moveFormField = YES;
    else if(textField == _headsetCap)
        _moveFormField = YES;
    
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _stemAngle)
        _moveFormField = NO;
    else if(textField == _stemLength)
        _moveFormField = NO;
    else if(textField == _spacers)
        _moveFormField = NO;
    else if(textField == _headsetCap)
        _moveFormField = NO;
    
    activeField = nil;
}
@end

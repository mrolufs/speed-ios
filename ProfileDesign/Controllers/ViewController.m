//
//  ViewController.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/5/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import <math.h>
#import "ViewController.h"
#import "LLModalPickerView.h"
#import "PDDataManager.h"
#import "FilterViewController.h"
#import "ResultsViewController.h"
#import "EvaluationManager.h"
#import "Product.h"

const static double STEM_ANGLE_ADDITIVE = 17;
//const static double STEM_LENGTH_ADDITIVE = 18.72;
const static double SPACERS_ADDITIVE = 20;



@interface ViewController () <UITextFieldDelegate, UIPickerViewDelegate>

@property (nonatomic, strong) FilterViewController *filterViewController;
@property (nonatomic, strong) ResultsViewController *resultsViewController;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *activeField;
@property (nonatomic, weak) IBOutlet UILabel *frameStackLabel;
@property (nonatomic, weak) IBOutlet UILabel *frameReachLabel;
@property (nonatomic, weak) IBOutlet UILabel *armRestStackLabel;
@property (nonatomic, weak) IBOutlet UILabel *armRestReachLabel;
@property (nonatomic, weak) IBOutlet UILabel *stemAngleLabel;
@property (nonatomic, weak) IBOutlet UILabel *stemLengthLabel;
@property (nonatomic, weak) IBOutlet UILabel *spacersLabel;
@property (nonatomic, weak) IBOutlet UILabel *headsetCapLabel;
@property (nonatomic, weak) IBOutlet UITextField *frameStack;
@property (nonatomic, weak) IBOutlet UITextField *frameReach;
@property (nonatomic, weak) IBOutlet UITextField *armRestStack;
@property (nonatomic, weak) IBOutlet UITextField *armRestReach;
@property (nonatomic, weak) IBOutlet UITextField *stemAngle;
@property (nonatomic, weak) IBOutlet UITextField *stemLength;
@property (nonatomic, weak) IBOutlet UITextField *spacers;
@property (nonatomic, weak) IBOutlet UITextField *headsetCap;
@property (nonatomic, weak) IBOutlet UIButton *backgroundButton;

@property (nonatomic) BOOL moveFormField;

@property (nonatomic, strong) NSArray *bikeFrameStackChoices;
@property (nonatomic, strong) NSArray *bikeFrameReachChoices;
@property (nonatomic, strong) NSArray *armRestStackChoices;
@property (nonatomic, strong) NSArray *armRestReachChoices;
@property (nonatomic, strong) NSArray *stemAngleChoices;
@property (nonatomic, strong) NSArray *stemLengthChoices;
@property (nonatomic, strong) NSArray *spacersChoices;
@property (nonatomic, strong) NSArray *headsetCapChoices;

@property (nonatomic, strong) NSArray *familyResultSet;
@property (nonatomic, strong) NSArray *productResultSet;

@property (nonatomic, strong) PDDataManager *dm;

- (IBAction)goNextField:(id)sender;
- (IBAction)submitButtonAction:(UIButton *)button;

@end


@implementation ViewController

@synthesize activeField;

- (void)viewDidLoad
{
    [super viewDidLoad];

    // LOAD DATA INITIALLY
    self.dm = [PDDataManager sharedInstance];
    [self.dm loadDataAsInitial:YES withCompletion:^{
        [SVProgressHUD showSuccessWithStatus:@"Data Loading\nComplete!"];
    }];
    
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
    
    // Setup Array List Objects
    self.familyResultSet = [[NSArray alloc] init];
    self.productResultSet = [[NSArray alloc] init];
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

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
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
    CGRect frame = _scrollView.frame;
    self.backgroundButton.frame = frame;
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


#pragma mark - Keyboard Methods

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


#pragma mark - UITextField Delegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
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


#pragma mark - Field Check

- (void)validateFormFields
{
    
}

#pragma mark - Button Actions

- (IBAction)submitButtonAction:(UIButton *)button
{
    [self validateFormFields];
//    NSString *bikeStack = self.frameStack.text;
//    NSString *bikeReach = self.frameReach.text;
//    NSString *fitStack = self.armRestStack.text;
//    NSString *fitReach = self.armRestReach.text;
//    NSString *sAngle = self.stemAngle.text;
//    NSString *sLength = self.stemLength.text;
//    NSString *spacersValue = self.spacers.text;
//    NSString *hsCap = self.headsetCap.text;

    NSString *bikeStack = @"545";
    NSString *bikeReach = @"380";
    NSString *fitStack = @"690";
    NSString *fitReach = @"395";
    NSString *sAngle = @"17";
    NSString *sLength = @"90";
    NSString *spacersValue = @"10";
    NSString *hsCap = @"5";
    
    NSInteger dstack = [fitStack intValue] - [bikeStack intValue];
    NSInteger dreach = 0;
    
    double deg = M_PI / 180;
    
    double stemLeft = sin(([sAngle intValue] + STEM_ANGLE_ADDITIVE) * deg) * [sLength intValue];
    double stemRight = cos((STEM_ANGLE_ADDITIVE) * deg) * (SPACERS_ADDITIVE + [spacersValue intValue] + [hsCap intValue]);
    double stemStack = stemLeft + stemRight;
    double stemReach = 0;
    
    double aerobar_stack = dstack - stemStack;
    double aerobar_reach = 0;
    
    dreach = [fitReach intValue] - [bikeReach intValue];
    
    double stemLeftReach = cos(([sAngle intValue] + STEM_ANGLE_ADDITIVE) * deg) * [sLength intValue];
    double stemRightReach = sin((STEM_ANGLE_ADDITIVE) * deg) * (SPACERS_ADDITIVE + [spacersValue intValue] + [hsCap intValue]);
    
    stemReach = stemLeftReach - stemRightReach;
    
    aerobar_reach = dreach - stemReach;
    
    NSInteger stackResult = round(aerobar_stack);
    NSInteger reachResult = round(aerobar_reach);
    
    
    EvaluationManager *em = [EvaluationManager sharedInstance];
    [em evaluateWithStack:stackResult withReach:reachResult withCompletion:^(NSArray *familyObjects, NSArray *productObjects)
    {
        self.familyResultSet = familyObjects;
        self.productResultSet = productObjects;
        
        if (self.familyResultSet.count > 2)
        {
            [self performSegueWithIdentifier:@"mainToFilter" sender:nil];
        }
        else
        {
            [self performSegueWithIdentifier:@"mainToResults" sender:nil];
        }
    }];
}

- (IBAction)resignAllFields:(id)sender
{
    [self.view endEditing:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"mainToFilter"])
    {
        self.filterViewController = segue.destinationViewController;
        self.filterViewController.familyList = self.familyResultSet;
        self.filterViewController.productList = self.productResultSet;
    }
    else if ([[segue identifier] isEqualToString:@"mainToResults"])
    {
        self.resultsViewController = segue.destinationViewController;
        self.resultsViewController.filteredProductList = self.productResultSet;
    }
}

@end

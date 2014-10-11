//
//  FilterViewController.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/8/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "FilterViewController.h"
#import "LLModalPickerView.h"

@interface FilterViewController () <UITextFieldDelegate, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) UITextField *activeField;
@property (strong, nonatomic) IBOutlet UITextField *typeOfRiding;
@property (strong, nonatomic) IBOutlet UITextField *triathlonCourse;
@property (strong, nonatomic) IBOutlet UITextField *positionChangeFrequency;

@property (nonatomic, assign) BOOL moveFormField;


@property (nonatomic, strong) NSArray *typeOfRidingChoices;
@property (nonatomic, strong) NSArray *typeOfHandPositionChoices;
@property (nonatomic, strong) NSArray *typeOfTriathlonCourseChoices;

@property (nonatomic, strong) NSMutableArray *filteredTs;
@property (nonatomic, strong) NSMutableArray *filteredOutTs;


-(IBAction)goNextField:(id)sender;
@end

@implementation FilterViewController

@synthesize activeField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)goBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupUI
{
    // SET FIELD ACTIONS
    [_typeOfRiding addTarget:self
                    action:@selector(goNextField:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    [_triathlonCourse addTarget:self
                 action:@selector(goNextField:)
       forControlEvents:UIControlEventEditingDidEndOnExit];
    [_positionChangeFrequency addTarget:self
                    action:@selector(goNextField:)
          forControlEvents:UIControlEventEditingDidEndOnExit];
    
    // SET DEFAULT VALUES FOR EACH TEXT FIELD
    [_typeOfRiding setText:@"Time Trial"];
    [_triathlonCourse setText:@"Short/Mid Course"];
    [_positionChangeFrequency setText:@"Yes"];
    
    // SET EACH FIELD DELEGATE
    [_typeOfRiding setDelegate:self];
    [_triathlonCourse setDelegate:self];
    [_positionChangeFrequency setDelegate:self];
    
    
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
    
    _typeOfRidingChoices = @[@"Time Trial", @"Triathlon"];
    _typeOfHandPositionChoices = @[@"Yes", @"No"];
    _typeOfTriathlonCourseChoices = @[@"Short/Mid Course", @"Long Course"];

    
}

-(IBAction)goNextField:(id)sender
{
    if (sender == _typeOfRiding)
        [_triathlonCourse becomeFirstResponder];
    else if (sender == _triathlonCourse)
        [_positionChangeFrequency becomeFirstResponder];
    else if (sender == _positionChangeFrequency)
        [_positionChangeFrequency becomeFirstResponder];
    else
        [_typeOfRiding becomeFirstResponder];
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
    if (textField == _typeOfRiding)
    {
        
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_typeOfRidingChoices];
        [pickerView setSelectedValue:_typeOfRiding.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            [_typeOfRiding setText:pickerView.selectedValue];
        }];
        return NO;
        
    } else if (textField == _triathlonCourse) {
        
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_typeOfTriathlonCourseChoices];
        [pickerView setSelectedValue:_triathlonCourse.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            [_triathlonCourse setText:pickerView.selectedValue];
        }];
        return NO;
        
    } else if (textField == _positionChangeFrequency) {
        
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_typeOfHandPositionChoices];
        [pickerView setSelectedValue:_positionChangeFrequency.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            [_positionChangeFrequency setText:pickerView.selectedValue];
        }];
        return NO;
        
    } else
        return YES;
    
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _typeOfRiding)
        _moveFormField = YES;
    else if(textField == _triathlonCourse)
        _moveFormField = YES;
    else if(textField == _positionChangeFrequency)
        _moveFormField = YES;

    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _typeOfRiding)
        _moveFormField = NO;
    else if(textField == _triathlonCourse)
        _moveFormField = NO;
    else if(textField == _positionChangeFrequency)
        _moveFormField = NO;
    
    activeField = nil;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (void) tFamilyFilter {
    
    NSString *typeOfRidingText = self.typeOfRiding.text;
    NSString *triathlonCourseText = self.triathlonCourse.text;
    NSString *multiPositionalText = self.positionChangeFrequency.text;
    
    self.filteredTs = [[NSMutableArray alloc] init];
    self.filteredOutTs = [[NSMutableArray alloc] init];

    
 
    //if Type of Riding...
    if([typeOfRidingText  isEqual: @"Time Trial"]){
        if([multiPositionalText  isEqual: @"Yes"]){
            //Log.i("TFAMILY", "TimeTrial, MultiPosition = Yes, ---> T2");
            [self.filteredOutTs addObject:@"T1"];
            [self.filteredOutTs addObject:@"T3"];
            [self.filteredOutTs addObject:@"T4"];
            
        }else{
            //Log.i("TFAMILY", "TimeTrial, MultiPosition = No, ---> T4");
            //filteredTs.add("T4");
            [self.filteredTs addObject:@"T4"];
            
            [self.filteredOutTs addObject:@"T1"];
            [self.filteredOutTs addObject:@"T2"];
            [self.filteredOutTs addObject:@"T3"];
            
        }
    }else if([typeOfRidingText  isEqual: @"Triathlon"]){
        if([triathlonCourseText isEqual: @"Short/Mid Course"]){
            if([multiPositionalText  isEqual: @"Yes"]){
                //Log.i("TFAMILY", "Triathlon, Short-Mid Course, MultiPosition = Yes, ---> T1/T2/T3");
                [self.filteredTs addObject:@"T1"];
                [self.filteredTs addObject:@"T2"];
                [self.filteredTs addObject:@"T3"];
                
                [self.filteredOutTs addObject:@"T4"];

            }else{
                //Log.i("TFAMILY", "Triathlon, Short-Mid Course, MultiPosition = No, ---> T4");
                [self.filteredTs addObject:@"T4"];
                
                [self.filteredOutTs addObject:@"T1"];
                [self.filteredOutTs addObject:@"T2"];
                [self.filteredOutTs addObject:@"T3"];
                
            }
        }else if([triathlonCourseText isEqual: @"Long Course"]){
            if([multiPositionalText  isEqual: @"Yes"]){
                //Log.i("TFAMILY", "Triathlon, Mid-Long Course, MultiPosition = Yes, ---> T1/T3");
                [self.filteredTs addObject:@"T1"];
                [self.filteredTs addObject:@"T3"];
                
                [self.filteredOutTs addObject:@"T2"];
                [self.filteredOutTs addObject:@"T4"];
            }else{
                //Log.i("TFAMILY", "Triathlon, Mid-Long Course, MultiPosition = No, ---> T4");

                [self.filteredTs addObject:@"T4"];
                
                [self.filteredOutTs addObject:@"T1"];
                [self.filteredOutTs addObject:@"T2"];
                [self.filteredOutTs addObject:@"T3"];
            }
        }
    }
    
}


@end

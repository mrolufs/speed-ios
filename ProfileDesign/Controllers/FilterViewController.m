//
//  FilterViewController.m
//  ProfileDesign
//
//  Created by Lawrence Leach on 6/8/14.
//  Copyright (c) 2014 Torqd Studios, LLC. All rights reserved.
//

#import "FilterViewController.h"
#import "ResultsViewController.h"
#import "LLModalPickerView.h"
#import "Product.h"

@interface FilterViewController () <UITextFieldDelegate, UIPickerViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *activeField;
@property (nonatomic, weak) IBOutlet UITextField *typeOfRiding;
@property (nonatomic, weak) IBOutlet UITextField *triathlonCourse;
@property (nonatomic, weak) IBOutlet UITextField *positionChangeFrequency;
@property (nonatomic, weak) IBOutlet UIButton *backgroundButton;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *triathlonViewConstraint;

@property (nonatomic, weak) IBOutlet UIView *triathlonView;
@property (nonatomic, weak) IBOutlet UIView *positionsView;
@property (nonatomic, weak) IBOutlet UIView *typeOfRidingView;

@property (nonatomic, assign) BOOL moveFormField;
@property (nonatomic, assign) BOOL isTriathlonCourse;

@property (nonatomic, strong) NSArray *typeOfRidingChoices;
@property (nonatomic, strong) NSArray *typeOfHandPositionChoices;
@property (nonatomic, strong) NSArray *typeOfTriathlonCourseChoices;

@property (nonatomic, strong) NSMutableArray *filteredTs;
@property (nonatomic, strong) NSMutableArray *filteredOutTs;
@property (nonatomic, strong) NSMutableArray *filteredProductList;

@property (nonatomic, strong) ResultsViewController *resultsViewController;

- (IBAction)goNextField:(id)sender;

@end


@implementation FilterViewController

@synthesize activeField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
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

- (void)viewWillAppear:(BOOL)animated
{
    self.isTriathlonCourse = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"\n\nFilter Screen\n-------\nFamily List: %@\nProduct List: %@\n\n", self.familyList, self.productList);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button Actions

- (IBAction)goBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submitButtonAction:(id)sender
{
    [self tFamilyFilter];
}

- (IBAction)backgroundButtonAction:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - UI Methods

- (void)setupUI
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

    // HIDE TRIATHALON VIEW
    self.triathlonView.frame = CGRectMake(20.0f, 101.0f, 280.0f, 0.0f);
    
    // SET SCROLLVIEW SIZE
    CGSize contentScrollSize = CGSizeMake(320.0f, 1024.0f);
    CGPoint contentOffsetSize = CGPointMake(0.0f, 0.0f);
    [_scrollView setContentSize:contentScrollSize];
    [_scrollView setContentOffset:contentOffsetSize];
}

- (void)setupPickerChoices
{
    _typeOfRidingChoices = @[@"Time Trial", @"Triathlon"];
    _typeOfHandPositionChoices = @[@"Yes", @"No"];
    _typeOfTriathlonCourseChoices = @[@"Short/Mid Course", @"Long Course"];
}

- (IBAction)goNextField:(id)sender
{
    if (sender == _typeOfRiding)
    {
        [_triathlonCourse becomeFirstResponder];
    }
    else if (sender == _triathlonCourse)
    {
        [_positionChangeFrequency becomeFirstResponder];
    }
    else if (sender == _positionChangeFrequency)
    {
        [_positionChangeFrequency becomeFirstResponder];
    }
    else
    {
        [_typeOfRiding becomeFirstResponder];
    }
}

- (IBAction)resignAllFields:(id)sender
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
    NSDictionary *info = [n userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect bkgndRect = activeField.superview.frame;
    bkgndRect.size.height += kbSize.height;
    [activeField.superview setFrame:bkgndRect];
    if (_moveFormField)
    {
        NSLog(@"stem angle");
    }
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

#pragma mark - Animate Triathlon View

- (void)animateTriathlonView
{
    NSTimeInterval animationDuration = 0.2f;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:animationDuration];

    if (self.isTriathlonCourse)
    {
        NSLog(@"\n\n----------\nAnimate IN Triathlon View\n----------\n");
        self.triathlonView.frame = CGRectMake(20.0f, 101.0f, 280.0f, 65.0f);;
    }
    else
    {
        NSLog(@"\n\n----------\nAnimate OUT Triathlon View\n----------\n");
        self.triathlonView.frame = CGRectMake(20.0f, 101.0f, 280.0f, 0);
    }
    
    [UIView commitAnimations];
    
//    if (self.isTriathlonCourse) {
//        self.triathlonView.frame =  CGRectMake(20.0f, 101.0f, 280.0f, 0);
//        [UIView animateWithDuration:0.25 animations:^{
//            self.triathlonView.frame =  CGRectMake(20.0f, 101.0f, 280.0f, 65.0f);
//        }];
//        self.isTriathlonCourse = YES;
//    }
//    else
//    {
//        [UIView animateWithDuration:0.25 animations:^{
//            self.triathlonView.frame =  CGRectMake(20.0f, 101.0f, 280.0f, 0);
//        }];
//        self.isTriathlonCourse = NO;
//    }

}

- (IBAction)btnToggleClick:(id)sender
{
    if (!self.isTriathlonCourse)
    {
        self.triathlonView.frame =  CGRectMake(130, 20, 0, 0);
        [UIView animateWithDuration:0.25 animations:^{
            self.triathlonView.frame =  CGRectMake(130, 30, 100, 200);
        }];
        self.isTriathlonCourse = YES;
    }
    else
    {
        [UIView animateWithDuration:0.25 animations:^{
            self.triathlonView.frame =  CGRectMake(130, 30, 0, 0);
        }];
        self.isTriathlonCourse = NO;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _typeOfRiding)
    {
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_typeOfRidingChoices];
        [pickerView setSelectedValue:_typeOfRiding.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            NSString *selectedText = pickerView.selectedValue;
            if ([selectedText isEqualToString:@"Triathlon"])
            {
                self.isTriathlonCourse = YES;
            }
            else
            {
                self.isTriathlonCourse = NO;
            }
            
            [self animateTriathlonView];
            [_typeOfRiding setText:selectedText];
        }];
        
        return NO;
    }
    else if (textField == _triathlonCourse)
    {
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_typeOfTriathlonCourseChoices];
        [pickerView setSelectedValue:_triathlonCourse.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            [_triathlonCourse setText:pickerView.selectedValue];
        }];
        
        return NO;
    }
    else if (textField == _positionChangeFrequency)
    {
        LLModalPickerView *pickerView = [[LLModalPickerView alloc] initWithValues:_typeOfHandPositionChoices];
        [pickerView setSelectedValue:_positionChangeFrequency.text];
        [pickerView presentInView:self.view withBlock:^(BOOL madeChoice) {
            [_positionChangeFrequency setText:pickerView.selectedValue];
        }];
        
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _typeOfRiding)
    {
        _moveFormField = YES;
    }
    else if(textField == _triathlonCourse)
    {
        _moveFormField = YES;
    }
    else if(textField == _positionChangeFrequency)
    {
        _moveFormField = YES;
    }

    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == _typeOfRiding)
    {
        _moveFormField = NO;
    }
    else if(textField == _triathlonCourse)
    {
        _moveFormField = NO;
    }
    else if(textField == _positionChangeFrequency)
    {
        _moveFormField = NO;
    }
    
    activeField = nil;
}

#pragma mark - Filter Methods

- (void) tFamilyFilter
{
    NSString *typeOfRidingText = self.typeOfRiding.text;
    NSString *triathlonCourseText = self.triathlonCourse.text;
    NSString *multiPositionalText = self.positionChangeFrequency.text;
    
    self.filteredTs = [[NSMutableArray alloc] init];
    self.filteredOutTs = [[NSMutableArray alloc] init];
 
    //if Type of Riding...
    if ([typeOfRidingText  isEqualToString: @"Time Trial"])
    {
        if ([multiPositionalText  isEqualToString: @"Yes"])
        {
            [self.filteredOutTs addObject:@"T1"];
            [self.filteredOutTs addObject:@"T3"];
            [self.filteredOutTs addObject:@"T4"];
        }
        else
        {
            [self.filteredTs addObject:@"T4"];
            [self.filteredOutTs addObject:@"T1"];
            [self.filteredOutTs addObject:@"T2"];
            [self.filteredOutTs addObject:@"T3"];
        }
    }
    else if ([typeOfRidingText  isEqualToString: @"Triathlon"])
    {
        if ([triathlonCourseText isEqualToString: @"Short/Mid Course"])
        {
            if ([multiPositionalText  isEqualToString: @"Yes"])
            {
                [self.filteredTs addObject:@"T1"];
                [self.filteredTs addObject:@"T2"];
                [self.filteredTs addObject:@"T3"];
                
                [self.filteredOutTs addObject:@"T4"];
            }
            else
            {
                [self.filteredTs addObject:@"T4"];
                
                [self.filteredOutTs addObject:@"T1"];
                [self.filteredOutTs addObject:@"T2"];
                [self.filteredOutTs addObject:@"T3"];
            }
        }
        else if ([triathlonCourseText isEqualToString: @"Long Course"])
        {
            if ([multiPositionalText  isEqualToString: @"Yes"])
            {
                [self.filteredTs addObject:@"T1"];
                [self.filteredTs addObject:@"T3"];
                
                [self.filteredOutTs addObject:@"T2"];
                [self.filteredOutTs addObject:@"T4"];
            }
            else
            {
                [self.filteredTs addObject:@"T4"];
                
                [self.filteredOutTs addObject:@"T1"];
                [self.filteredOutTs addObject:@"T2"];
                [self.filteredOutTs addObject:@"T3"];
            }
        }
    }
    
    // Now filter the list
    NSMutableIndexSet *indexesToDelete = [NSMutableIndexSet indexSet];
    
    for (int i = 0; i < self.productList.count; i++)
    {
        NSString *productItem = (NSString *)[self.productList[i] description];
        //NSLog(@"\n %d. %@\n", i,productItem);
        
        for (NSString *item in self.filteredOutTs)
        {
            //NSLog(@"\nItem = %@\n", item);
            if ([productItem rangeOfString:item].location == NSNotFound)
            {
                //[self.filteredProductList addObject:productItem];
                //NSLog(@"\n\nAdded one!\n\n");
            }
            else
            {
                [indexesToDelete addIndex:i];
                break;
            }
        }
    }
    
    [self.productList removeObjectsAtIndexes:indexesToDelete];
    //NSLog(@"\n\nFiltered Product List\n-----\n%@\n", self.filteredProductList);
    
    [self performSegueWithIdentifier:@"filterToResults" sender:nil];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"filterToResults"])
    {
        self.resultsViewController = segue.destinationViewController;
        self.resultsViewController.filteredProductList = self.productList;
        self.resultsViewController.stack = self.stack;
        self.resultsViewController.reach = self.reach;
    }
}

@end

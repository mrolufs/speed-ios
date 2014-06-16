//
//  LLModalPickerView.h
//  Style Thief
//
//  Created by Lawrence Leach on 11/1/12.
//  Copyright (c) 2012 Torqd Studios, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^LLModalPickerViewCallback)(BOOL madeChoice);

@interface LLModalPickerView : UIView <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, assign) NSString *selectedValue;
@property (nonatomic, retain) NSArray *values;

/* Initializes a new instance of the picker with the values to present to the user.
 (Note: call presentInView:withBlock: or presentInWindowWithBlock: to display the control)
 */
- (id)initWithValues:(NSArray *)values;

/* Presents the control embedded in the provided view.
 Arguments:
 view        - The view that will contain the control.
 callback    - The block that will receive the result of the user action.
 */
- (void)presentInView:(UIView *)view withBlock:(LLModalPickerViewCallback)callback;

/* Presents the control embedded in the window.
 Arguments:
 callback    - The block that will receive the result of the user action.
 */
- (void)presentInWindowWithBlock:(LLModalPickerViewCallback)callback;



@end

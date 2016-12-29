//
//  BNRDetailViewController.m
//  BNRHomepwner
//
//  Created by Richard Wang on 2016/12/5.
//  Copyright © 2016年 Richard Wang. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRImageStore.h"
#import "BNRItemStore.h"

@interface BNRDetailViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate, UITextFieldDelegate, UIPopoverControllerDelegate>

@property (nonatomic, strong) UIPopoverController *imagePickerPopover;
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serialNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;

@end

@implementation BNRDetailViewController

- (instancetype)initForNewItem:(BOOL)isNew
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        self.restorationIdentifier = NSStringFromClass([self class]);
        self.restorationClass = [self class];
        
        if (isNew)
        {
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
        }
        
        NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
        [defaultCenter addObserver:self selector:@selector(updateFonts) name:UIContentSizeCategoryDidChangeNotification object:nil];
    }
    
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    @throw [NSException exceptionWithName:@"Wrong initializer" reason:@"Use initForNewItem:" userInfo:nil];
    return nil;
}

- (void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:nil];
    iv.contentMode = UIViewContentModeScaleAspectFit;
    //告诉自动布局系统不要将自动缩放掩码转换为约束
    iv.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:iv];
    self.imageView = iv;
    
    //将 imageView 垂直方向的优先级设置为比其他视图低的数值
    [self.imageView setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisVertical];
    [self.imageView setContentCompressionResistancePriority:700 forAxis:UILayoutConstraintAxisHorizontal];
    
    NSDictionary *nameMap = @{@"imageView" : self.imageView,
                              @"dateLabel" : self.dateLabel,
                              @"toolbar" : self.toolBar};
    
    NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[imageView]-0-|" options:0 metrics:nil views:nameMap];
    NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[dateLabel]-8-[imageView]-8-[toolbar]" options:0 metrics:nil views:nameMap];
    [self.view addConstraints:horizontalConstraints];
    [self.view addConstraints:verticalConstraints];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
    [self prepareViewsForOrientation:io];
    
    BNRItem *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    NSString *itemKey = item.itemKey;
    UIImage *imageToDisplay = [[BNRImageStore sharedStore] imageForKey:itemKey];
    self.imageView.image = imageToDisplay;
    
    [self updateFonts];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    //保存
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = self.valueField.text.intValue;
}

- (void)updateFonts
{
    UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    
    self.nameLabel.font = font;
    self.serialNumberLabel.font = font;
    self.valueLabel.font = font;
    self.dateLabel.font = font;
    
    self.nameField.font = font;
    self.serialNumberField.font = font;
    self.valueField.font = font;
}

- (void)prepareViewsForOrientation:(UIInterfaceOrientation)orientation
{
    // 如果是 iPad，则不执行任何操作
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        return;
    }
    
    // 判断设备是否处于横排方向
    if (UIInterfaceOrientationIsLandscape(orientation))
    {
        self.imageView.hidden = YES;
        self.cameraButton.enabled = NO;
    }
    else
    {
        self.imageView.hidden = NO;
        self.cameraButton.enabled = YES;
    }
}

#ifdef __IPHONE_8_0
- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    __weak typeof(self) weakSelf = self;
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        
    } completion:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        [weakSelf prepareViewsForOrientation:orientation];
    }];
}
#else
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [self prepareViewsForOrientation:toInterfaceOrientation];
}
#endif

- (IBAction)backgroundTapped:(id)sender
{
    [self.view endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.valueField resignFirstResponder];
}

- (void)save:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

- (void)cancel:(id)sender
{
    [[BNRItemStore sharedStore] removeItem:self.item];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:self.dismissBlock];
}

+ (UIViewController *)viewControllerWithRestorationIdentifierPath:(NSArray *)identifierComponents coder:(NSCoder *)coder
{
    BOOL isNew = NO;
    if ([identifierComponents count] == 3)
    {
        isNew = YES;
    }
    return [[self alloc] initForNewItem:isNew];
}

- (void)encodeRestorableStateWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.item.itemKey forKey:@"item.itemKey"];
    
    // 保存 UITextField 对象中的文本
    self.item.itemName = self.nameField.text;
    self.item.serialNumber = self.serialNumberField.text;
    self.item.valueInDollars = [self.valueField.text intValue];
    // 保存修改
    [[BNRItemStore sharedStore] saveChanges];
    
    [super encodeRestorableStateWithCoder:coder];
}

- (void)decodeRestorableStateWithCoder:(NSCoder *)coder
{
    NSString *itemKey = [coder decodeObjectForKey:@"item.itemKey"];
    for (BNRItem *item in [[BNRItemStore sharedStore] allItems])
    {
        if ([itemKey isEqualToString:item.itemKey])
        {            
            self.item = item;
            break;
        }
    }
    
    [super decodeRestorableStateWithCoder:coder];
}

#pragma mark - UIImagePickerViewController
- (IBAction)takePicture:(id)sender
{
    if ([self.imagePickerPopover isPopoverVisible])
    {
        //如果 imagePickerPopover 指向的是有效的 UIPopoverController 对象，
        //并且该对象的视图是可见的，就关闭这个对象，并将其设置为 nil
        [self.imagePickerPopover dismissPopoverAnimated:YES];
        self.imagePickerPopover = nil;
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    //如果设备支持相机，就使用拍照模式
    //否则让用户从照片库中选择照片
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;

    imagePicker.allowsEditing = YES;
    imagePicker.showsCameraControls = YES;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //通过 info 字典获取选择的照片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self.item setThumnailFromImage:image];
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    //将照片放入 UIImageView 对象
    self.imageView.image = image;
    
    // 关闭 UIImagePickerController 对象
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)dealloc
{
    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
    [defaultCenter removeObserver:self];
}

@end

#import "MNCLoginViewController.h"
#import "AppDelegate.h"


@interface MNCLoginViewController ()

@property (strong, nonatomic) IBOutlet UILabel *promptLabel;

@property (strong, nonatomic) IBOutlet UITextField *usernameField;

@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@end



@implementation MNCLoginViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"User"] != nil)
    {
        [self performSegueWithIdentifier:@"LoginSegue" sender:nil];
        return;
    }
    
    self.navigationItem.title = @"ios-sinch-messaging-tutorial";
    self.promptLabel.hidden = YES;
    UITapGestureRecognizer *tapViewGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapOnView)];
    [self.view addGestureRecognizer:tapViewGR];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"LoginSegue"]) {
        MNCChatMateListViewController *destViewController = segue.destinationViewController;
        destViewController.myUserId = self.usernameField.text;
    }
}
// Tab the view to dismiss keyboard
- (void)didTapOnView {
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

- (IBAction)signup:(id)sender {
    PFUser *pfUser = [PFUser user];
    pfUser.username = self.usernameField.text;
    pfUser.password = self.passwordField.text;
    
    __weak typeof(self) weakSelf = self;
    [pfUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            weakSelf.promptLabel.textColor = [UIColor greenColor];
            weakSelf.promptLabel.text = @"Signup successful!";
            weakSelf.promptLabel.hidden = NO;
            [weakSelf login:nil];
            
        } else {
            weakSelf.promptLabel.textColor = [UIColor redColor];
            weakSelf.promptLabel.text = [error userInfo][@"error"];
            weakSelf.promptLabel.hidden = NO;
        }
    }];
}

- (IBAction)login:(id)sender {
    __weak typeof(self) weakSelf = self;
    [PFUser logInWithUsernameInBackground:self.usernameField.text
                                 password:self.passwordField.text
                                    block:^(PFUser *pfUser, NSError *error)
     {
         if (pfUser && !error) {
             // Proceed to next screen after successful login.
             weakSelf.promptLabel.hidden = YES;
             //add this
             AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
             [appDelegate initSinchClient:self.usernameField.text];
             //
             [weakSelf performSegueWithIdentifier:@"LoginSegue" sender:self];
          
             
         } else {
             // The login failed. Show error.
             weakSelf.promptLabel.textColor = [UIColor redColor];
             weakSelf.promptLabel.text = [error userInfo][@"error"];
             weakSelf.promptLabel.hidden = NO;
         }
     }];
}


@end

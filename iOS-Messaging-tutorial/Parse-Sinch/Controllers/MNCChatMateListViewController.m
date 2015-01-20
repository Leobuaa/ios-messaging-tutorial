
#import "MNCChatMateListViewController.h"



@interface MNCChatMateListViewController ()

@end



@implementation MNCChatMateListViewController
@synthesize chatMatesArray, myUserId;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.myUserId;
    
    
    self.chatMatesArray = [[NSMutableArray alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.activeDialogViewController = nil;  /* add this line */
    [self retrieveChatMatesFromParse];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Segue to open a dialog
    if ([segue.identifier isEqualToString:@"OpenDialogSegue"]) {
        self.activeDialogViewController = segue.destinationViewController;
        NSInteger chatMateIndex = [[self.tableView indexPathForCell:(UITableViewCell *)sender] row];
        
        self.activeDialogViewController.chatMateId = self.chatMatesArray[chatMateIndex];
        self.activeDialogViewController.myUserId = self.myUserId;   /* add this line */
        return;
    }
}

- (void)dealloc {
    //Logout current user
    [PFUser logOut];
}





- (void)retrieveChatMatesFromParse {
    [self.chatMatesArray removeAllObjects];
    
    PFQuery *query = [PFUser query];
    [query orderByAscending:@"username"];
    [query whereKey:@"username" notEqualTo:self.myUserId];
    
    __weak typeof(self) weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *chatMateArray, NSError *error) {
        if (!error) {
            for (int i = 0; i < [chatMateArray count]; i++) {
                [weakSelf.chatMatesArray addObject:chatMateArray[i][@"username"]];
            }
            [weakSelf.tableView reloadData];
        } else {
            NSLog(@"Error: %@", error.description);
        }
    }];
}






#pragma mark UITableViewDataSource protocol methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.chatMatesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatMateListPrototypeCell" forIndexPath:indexPath];
    NSString *chatMateId = [self.chatMatesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = chatMateId;
    
    return cell;
}

@end

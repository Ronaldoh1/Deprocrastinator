//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Ronald Hernandez on 3/16/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "ToDoViewController.h"

@interface ToDoViewController () <UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (nonatomic) NSMutableArray *itemsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property(nonatomic) int indexForItemToDelete;

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.itemsArray = [NSMutableArray arrayWithObjects: @"To Do1", @"To Do2", @"To Do3", @"To Do4",nil ];
    
   // self.inputField.backgroundColor = [UIColor redColor];


    

}


- (IBAction)addItem:(UIButton *)sender {

    //UITableViewCell *cell = [UITableViewCell new];

   // cell.textLabel.text =    self.inputField.text;

    [self.itemsArray addObject:self.inputField.text];


    [self.inputField resignFirstResponder];

    [self.tableview reloadData];

    self.inputField.text = @"";

    


}

- (IBAction)editItem:(UIBarButtonItem *)sender {

    if([sender.title isEqualToString:@"Edit"])
    {
        [sender setTitle:@"Done"];
        [self.tableview setEditing: YES animated: YES];



        
        

    } else if ([sender.title isEqualToString:@"Done"])
    {
        [sender setTitle:@"Edit"];
           [self.tableview setEditing: NO animated: NO];
    }



}

-(void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:true animated:true];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //remove the deleted object from your data source.
        //If your data source is an NSMutableArray, do this

        self.indexForItemToDelete = indexPath.row;

        [self displayAlert];

    }
}


-(void) displayAlert{

  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Delete Reminder?" message:@"Are you should want to delete selected item?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    
    
            //alert.tag = 1;
    
           // [alert addButtonWithTitle:@"Delete"];
           [alert show];

}
// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    //button index 0 means the user presses the cancel button.
    if (buttonIndex == 0) {


    }else{
        //else this means that the user click on delete and should continue to remove the item from

        [self.itemsArray removeObjectAtIndex:self.indexForItemToDelete];
        [self.tableview reloadData]; // tell table to refresh now




    }
}

#pragma mark - UITableViewDataSource protocalls

///this allows to custumize the number of of sections in the table view.

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

//This is how many rows we're going to display based on the itemsArray count.
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.itemsArray.count;

}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    cell.textLabel.text = [self.itemsArray objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];

  //  NSLog(@"%ld", (long)indexPath.row);

  cell.backgroundColor = [UIColor greenColor];
}

#pragma mark - UIGestureRecognizerDelegate Protocols

- (IBAction)swipeRightGestureRecognizer:(UISwipeGestureRecognizer *)sender {

    [self handleGestureRecognizer:sender];

}

-(void)handleGestureRecognizer: (UISwipeGestureRecognizer *) gestureRecognizer {
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded){
        CGPoint location = [gestureRecognizer locationInView:self.tableview];
        NSIndexPath *indexPath = [self.tableview indexPathForRowAtPoint:location];
        UITableViewCell *cell = [self.tableview cellForRowAtIndexPath:indexPath];

        //First we need to check for the case when the color of the text is black. (Itinial color for the cell lable). Otherwise the other if statements will not be executed.
        
        if (cell.textLabel.textColor == [UIColor blackColor]){
            cell.textLabel.textColor= [UIColor redColor];
        }
        else if(cell.textLabel.textColor == [UIColor redColor])
        {
            cell.textLabel.textColor= [UIColor yellowColor];
        }
        else if(cell.textLabel.textColor == [UIColor yellowColor]){
            cell.textLabel.textColor= [UIColor greenColor];

        }
        else if(cell.textLabel.textColor == [UIColor greenColor]){
            cell.textLabel.textColor= [UIColor redColor];
        }

    }

}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [self.itemsArray insertObject:[self.itemsArray objectAtIndex: sourceIndexPath.row] atIndex:destinationIndexPath.row];
    [self.itemsArray removeObject:[self.itemsArray objectAtIndex:sourceIndexPath.row]];

}



@end

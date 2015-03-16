//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Ronald Hernandez on 3/16/15.
//  Copyright (c) 2015 Ron. All rights reserved.
//

#import "ToDoViewController.h"

@interface ToDoViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@property (nonatomic) NSMutableArray *itemsArray;

@end

@implementation ToDoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    


}


- (IBAction)addItem:(UIButton *)sender {

}
- (IBAction)editItem:(UIBarButtonItem *)sender {
}


#pragma mark - UITableViewDataSource protocalls
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 0;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    return nil;


}

@end

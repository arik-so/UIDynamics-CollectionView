//
//  CVTViewController.m
//  CollectionViewTest
//
//  Created by Arik Sosman on 7/13/13.
//  Copyright (c) 2013 Sosman & Perk. All rights reserved.
//

#import "CVTViewController.h"

@interface CVTViewController ()

@end

@implementation CVTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:NO animated:YES];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 15;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // NSString *identifier = [NSString stringWithFormat:@"Cell", indexPath.section, indexPath.row];
    NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    cell.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
// ; // = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    double max = 0x100000000;
    
    double red = ((double)arc4random() / max);
    double green = ((double)arc4random() / max);
    double blue = ((double)arc4random() / max);
    
    cell.backgroundColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
    
    
    
    
    return cell;
    
}

@end

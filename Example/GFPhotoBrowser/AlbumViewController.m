//
//  AlbumViewController.m
//  Photos
//
//  Created by 熊国锋 on 2016/11/4.
//  Copyright © 2016年 viroyal. All rights reserved.
//

#import "AlbumViewController.h"
#import "PhotosDataSource.h"
#import <Masonry/Masonry.h>

@interface AlbumCell : UITableViewCell

@property (nonatomic, copy) PhotoSectionInfo        *sectionInfo;

@property (nonatomic, strong)   UIImageView         *iconView;
@property (nonatomic, strong)   UILabel             *labelView;

+ (NSString *)cellIdentifier;

@end

@implementation AlbumCell

+ (NSString *)cellIdentifier {
    return NSStringFromClass(self);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSInteger padding = 1;
        
        self.iconView = [[UIImageView alloc] init];
        self.iconView.contentMode = UIViewContentModeScaleAspectFill;
        self.iconView.layer.masksToBounds = YES;
        [self.contentView addSubview:self.iconView];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(padding);
            make.top.equalTo(self.contentView.mas_top).offset(padding);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(padding);
            make.width.equalTo(self.iconView.mas_height);
        }];
        
        self.labelView = [[UILabel alloc] init];
        [self.contentView addSubview:self.labelView];
        [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(padding);
            make.top.equalTo(self.contentView);
            make.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView);
        }];
    }
    
    return self;
}

- (void)setSectionInfo:(PhotoSectionInfo *)sectionInfo {
    self.labelView.text = sectionInfo.title;
    
    PHAsset *asset = [sectionInfo.objects firstObject];
    [[PHImageManager defaultManager] requestImageForAsset:asset
                                               targetSize:CGSizeMake(128, 128)
                                              contentMode:PHImageContentModeDefault
                                                  options:nil
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                self.iconView.image = result;
                                            }];
}


@end

@interface AlbumViewController () < PhotosDataDelegate >

@property (nonatomic, strong) PhotosDataSource          *dataSource;

@end

@implementation AlbumViewController

- (instancetype)init {
    if (self = [super initWithStyle:UITableViewStylePlain]) {
        [self.tableView registerClass:[AlbumCell class]
               forCellReuseIdentifier:[AlbumCell cellIdentifier]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Photos";
    
    self.dataSource = [[PhotosDataSource alloc] init];
    self.dataSource.delegate = self;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                                                              style:UIBarButtonItemStylePlain
                                                                             target:self
                                                                             action:@selector(closeView)];
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
}

#pragma mark - PhotosDataDelegate

- (void)dataInitWillBegin {
    
}

- (void)dataInitDidFinish {
    [self.tableView reloadData];
}

- (void)closeView {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource numberOfSections];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[AlbumCell cellIdentifier]
                                                            forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(AlbumCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.sectionInfo = [self.dataSource sectionInfoForSection:indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PhotoSectionInfo *sectionInfo = [self.dataSource sectionInfoForSection:indexPath.row];
    [self.delegate album:self selectSection:sectionInfo];
}

@end

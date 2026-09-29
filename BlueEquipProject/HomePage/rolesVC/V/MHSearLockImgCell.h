//
//  MHSearLockImgCell.h
//  BlueEquipProject
//
//  Created by Edwin on 2024/3/9.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MHSearLockImgCell : UITableViewCell

+ (instancetype)cellWithTabelView:(UITableView *)tableView;

- (void)addTwoModelToDataModel:(MKMapItem *)model coor:(CLLocationCoordinate2D)coor;
@end

NS_ASSUME_NONNULL_END

//
//  SpotAnnotation.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import MapKit

class SpotAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var restaurantId: String?
    var restaurantName: String?
    var restaurantAddress: String?
    var restaurantPhoneNumber: String?
    var restaurantBusinessHours: String?
    var restaurantSiteUrl: String?
    var restaurantImageUrl: String?
    var restaurantLatitude: Double?
    var restaurantLongitude: Double?
}

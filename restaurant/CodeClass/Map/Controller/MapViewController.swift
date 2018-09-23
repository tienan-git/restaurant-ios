//
//  MapViewController.swift
//  restaurant
//
//  Created by 劉鉄男 on 2018/9/23.
//  Copyright © 2018年 劉鉄男. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var routeCancelButton: UIButton!
    
    var locationManager: CLLocationManager!
    var userLocation: CLLocationCoordinate2D!
    var tappedAnnotationLocation: CLLocationCoordinate2D!
    var toLocation: CLLocationCoordinate2D!
    var policyLineIsShowing: Bool = false
    var policyLineIsFirstShowing: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        // 端末が位置サービスをサポートするか、アプリに位置サービスの使用権限を付与しているかを確認する
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            setLocationManager()
            setOriginLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addAnnotations()
        addCircleOverlay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - メソッド：CLLocationManagerを初期設定する
    func setLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
    }
    
    // MARK: - メソッド：MapViewの初期表示範囲を設定する
    func setOriginLocation() {
        guard let center = locationManager.location?.coordinate else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: center, span: span)
        mapView.setRegion(region, animated: true)
        mapView.setUserTrackingMode(MKUserTrackingMode.followWithHeading, animated: true)
    }
    
    // MARK: - メソッド：MapViewにゆたぽん捕獲範囲サークルを追加する
    func addCircleOverlay() {
        for overlay in mapView.overlays {
            if overlay is MKCircle {
                mapView.remove(overlay)
            }
        }
        var circle = MKCircle()
        if userLocation != nil {
            circle = MKCircle.init(center: userLocation, radius: 1000)
        }
        mapView.add(circle)
    }
    
    // MARK: - メソッド：MapViewに施設ピンマークを追加する
    func addAnnotations() {
        
        mapView.removeAnnotations(mapView.annotations)
        
        // 施設情報取得
        let realm = try! Realm()
        let spots = realm.objects(Spot.self)
        dPrint("spots: \(spots)")
        
        // 施設アノテーション追加
        var spotAnnotations = [SpotAnnotation]()
        for spot in spots {
            let spotAnnotation = SpotAnnotation()
            spotAnnotation.coordinate = CLLocationCoordinate2DMake(Double(spot.spotLatitude)!, Double(spot.spotLongitude)!)
            spotAnnotation.spotName = spot.spotName
            spotAnnotation.spotType = spot.spotType
            spotAnnotation.spotImageUrl = spot.spotImageUrl
            spotAnnotation.spotServiceArray.append(spot.spotService1)
            spotAnnotation.spotServiceArray.append(spot.spotService2)
            spotAnnotation.spotServiceArray.append(spot.spotService3)
            spotAnnotation.spotServiceArray.append(spot.spotService4)
            spotAnnotation.spotServiceArray.append(spot.spotService5)
            spotAnnotation.spotServiceArray.append(spot.spotService6)
            spotAnnotation.spotServiceArray.append(spot.spotService7)
            spotAnnotation.spotServiceArray.append(spot.spotService8)
            spotAnnotations.append(spotAnnotation)
        }
        mapView.addAnnotations(spotAnnotations)
    }
    
    // MARK: - イベント：「現在地に戻る」ボタン（画面右下の画像）をタップする時
    @IBAction func backOriginAction(_ sender: Any) {
        dPrint("現在地戻りボタンをタップする時")
        setOriginLocation()
        addCircleOverlay()
    }
    
    // MARK: - イベント：「経路取消」ボタン（画面中央下の文言）をタップする時
    @IBAction func routeCancel(_ sender: UIButton) {
        policyLineIsShowing = false
        for overlay in mapView.overlays {
            if overlay is MKPolyline {
                mapView.remove(overlay)
            }
        }
        routeCancelButton.isHidden = true
    }
    
    // MARK: - イベント：「経路案内」ボタン（施設情報画面にある）をタップする時
    func routeGuideOrOnlyForClose() {
        dPrint("経路案内ボタンをタップする時")
        policyLineIsShowing = true
        policyLineIsFirstShowing = true
        toLocation = tappedAnnotationLocation
        getRoute()
        routeCancelButton.isHidden = false
    }
    
    // MARK: - メソッド：経路を検索し、検索結果を地図に表示させる
    func getRoute() {
        // 現在地と目的地のMKPlacemarkを生成
        let fromPlacemark = MKPlacemark(coordinate:userLocation, addressDictionary:nil)
        let toPlacemark   = MKPlacemark(coordinate:toLocation, addressDictionary:nil)
        
        // MKPlacemark から MKMapItem を生成
        let fromItem = MKMapItem(placemark:fromPlacemark)
        let toItem   = MKMapItem(placemark:toPlacemark)
        
        // MKMapItem をセットして MKDirectionsRequest を生成
        let request = MKDirectionsRequest()
        
        request.source = fromItem
        request.destination = toItem
        request.requestsAlternateRoutes = false // 単独の経路を検索
        request.transportType = MKDirectionsTransportType.walking
        
        let directions = MKDirections(request:request)
        directions.calculate(completionHandler: {
            (response:MKDirectionsResponse!, error:Error!) -> Void in
            if (error != nil || response.routes.isEmpty) {
                return
            }
            let route: MKRoute = response.routes[0] as MKRoute
            // 経路を描画
            for overlay in self.mapView.overlays {
                if overlay is MKPolyline {
                    self.mapView.remove(overlay)
                }
            }
            self.mapView.add(route.polyline)
            // 現在地と目的地を含む表示範囲を設定する
            if self.policyLineIsFirstShowing == true {
                self.showUserAndDestinationOnMap()
            }
        })
    }
    
    // MARK: - メソッド：初回経路表示する時の最適な地図表示範囲を計算する
    func showUserAndDestinationOnMap()
    {
        policyLineIsFirstShowing = false
        
        // 現在地と目的地を含む矩形を計算
        let maxLat:Double = fmax(userLocation.latitude,  tappedAnnotationLocation.latitude)
        let maxLon:Double = fmax(userLocation.longitude, tappedAnnotationLocation.longitude)
        let minLat:Double = fmin(userLocation.latitude,  tappedAnnotationLocation.latitude)
        let minLon:Double = fmin(userLocation.longitude, tappedAnnotationLocation.longitude)
        
        // 地図表示するときの緯度、経度の幅を計算
        let mapMargin:Double = 1.5;  // 経路が入る幅(1.0)＋余白(0.5)
        let leastCoordSpan:Double = 0.005;    // 拡大表示したときの最大値
        let span_x:Double = fmax(leastCoordSpan, fabs(maxLat - minLat) * mapMargin);
        let span_y:Double = fmax(leastCoordSpan, fabs(maxLon - minLon) * mapMargin);
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(span_x, span_y);
        
        // 現在地を目的地の中心を計算
        let center:CLLocationCoordinate2D = CLLocationCoordinate2DMake((maxLat + minLat) / 2, (maxLon + minLon) / 2);
        let region:MKCoordinateRegion = MKCoordinateRegionMake(center, span);
        
        mapView.setRegion(mapView.regionThatFits(region), animated:true);
    }
}

extension MapViewController: MKMapViewDelegate, SpotViewDelegate {
    
    // MARK: - イベント：施設ピンマークをタップする時
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        dPrint("アノテーションをタップする時")
        if view.annotation is MKUserLocation {
            return
        }
        
        // 施設情報画面を表示させる
        tappedAnnotationLocation = view.annotation?.coordinate
        let spotAnnotation = view.annotation as! SpotAnnotation
        let spotName = spotAnnotation.spotName
        let spotType = spotAnnotation.spotType
        let spotImageUrl = spotAnnotation.spotImageUrl
        let spotServiceArray = spotAnnotation.spotServiceArray
        let spotView = Bundle.main.loadNibNamed("SpotView", owner: nil, options: nil)?.first as! SpotView
        spotView.makeMyWindow(spotName: spotName, spotType: spotType, spotServiceArray: spotServiceArray, spotImageUrl: spotImageUrl)
        spotView.delegate = self
        
        // ピンマークの選択を解除する（同じピンマークを再度タップするための制御）
        for annotaion in mapView.selectedAnnotations {
            mapView.deselectAnnotation(annotaion, animated: false)
        }
    }
    
    // MARK: - イベント：施設ピンマークが表示される時
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        dPrint("アノテーションが表示される時")
        if annotation is MKUserLocation {
            return nil
        }
        
        // 施設ピンマークをカスタマイズする
        let identifier = "item"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        annotationView?.annotation = annotation// 重要
        annotationView?.image = UIImage(named: "pinMarker")// 设置大头针的图片
        annotationView?.centerOffset = CGPoint(x: 0, y: 0)// 设置大头针中心偏移量
        return annotationView
        
    }
    
    // MARK: - イベント：捕獲範囲サークル、案内経路が表示される時
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        // サークルを描画する時
        if overlay is MKCircle {
            dPrint("オーバレイ「サークル」が描画される時")
            let circleRenderer = MKCircleRenderer(circle: overlay as! MKCircle)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.05)
            circleRenderer.strokeColor = UIColor.blue.withAlphaComponent(0.2)
            circleRenderer.lineWidth = 2
            circleRenderer.miterLimit = 10
            return circleRenderer
        }
        
        // 経路を描画する時
        if policyLineIsShowing == true {
            if overlay is MKPolyline {
                dPrint("オーバレイ「経路」が描画される時")
                let polylineRenderer = MKPolylineRenderer(overlay: overlay)
                polylineRenderer.strokeColor = UIColor.blue
                polylineRenderer.lineWidth = 5
                return polylineRenderer
            }
        }
        
        // サークル、経路以外を描画する時
        dPrint("オーバレイ「サークル」「経路」以外が描画される時")
        return MKOverlayRenderer()
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    // MARK: - イベント：ユーザー位置が変わる時
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        dPrint("GPS現在位置が変わる時")
        for location in locations {
            print("緯度:\(location.coordinate.latitude) 経度:\(location.coordinate.longitude) 取得時刻:\(location.timestamp.description)")
        }
        userLocation = locations.last?.coordinate
        addCircleOverlay()
        if policyLineIsShowing == true {
            getRoute()
        }
    }
}

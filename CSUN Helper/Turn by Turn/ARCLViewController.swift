//
//  ARCLViewController.swift
//  AugmentedReality
//
//  Created by Bibinur on 11/9/19.
//  Copyright © 2019 Bibinur. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import ARKit
import SafariServices

@available(iOS 11.0, *)
class ARCLViewController: UIViewController, CLLocationManagerDelegate {
    

    @IBOutlet weak var resetButton: UIButton!
    var locationManager: CLLocationManager!
    var latestLocation: CLLocation?
    
    var sceneLocationView: SceneLocationView!
    
    var pois: [PointOfInterest]!
    var locationAnnotationNode2POI: [LocationTextAnnotationNode: PointOfInterest]!
    var selectedPOI: PointOfInterest?
    var params: [String]!
    var drawnLocationNodes: [LocationNode]!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleResetButtonStatus()
        setupLocation()
        setupPOIs()
        
        setupARScene()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Run the view's AR session
        sceneLocationView.run()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // draw the AR scene
        drawARScene()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneLocationView.pause()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        sceneLocationView.frame = view.bounds
    }
    func toggleResetButtonStatus() {
        if selectedPOI == nil {
            hideResetButton()
        }
        else {
            showResetButton()
        }
    }
    
    func hideResetButton() {
        // hide
        resetButton.tintColor = .clear
        resetButton.isEnabled = false
        resetButton.isAccessibilityElement = false
    }
    
    func showResetButton() {
        // show
        resetButton.tintColor = .blue
        resetButton.isEnabled = true
        resetButton.isAccessibilityElement = true
    }
/*    @IBAction func resetButtonPressed(_ sender: Any) {
        resetARScene()
    }*/
    

    @IBAction func resetButtonPressed(_ sender: Any) {
    resetARScene()
    }
    // MARK: AR scene actions
    
    @objc
    func handleARObjectTap(gestureRecognizer: UITapGestureRecognizer) {
        guard gestureRecognizer.view != nil else {
            return
        }
        
        // ignore touches when already displaying directions
        if selectedPOI != nil {
            return
        }
        
        if gestureRecognizer.state == .ended {
            
            // Look for an object directly under the touch location
            let location: CGPoint = gestureRecognizer.location(in: sceneLocationView)
            let hits = sceneLocationView.hitTest(location, options: nil)
            if !hits.isEmpty {
                
                // select the first match
                if let tappedNode = hits.first?.node.parent as? LocationTextAnnotationNode {
                    if let poi = locationAnnotationNode2POI?[tappedNode] {
                        presentPOIAlertViewfor(poi: poi)
                    }
                }
            }
            
        }
    }
    
    
    // MARK: location
    
    func setupLocation() {
        // Setup location manager
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters // don't need more for walking between POIs
        
        // request location updates
        locationManager?.startUpdatingLocation()
        locationManager?.requestWhenInUseAuthorization()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager didFailWithError: %@", error)
        
        // show a confirmation alert
        self.presentConfirmationAlertViewWith(
            title: "Location Error",
            message: "Failed to get your current location.",
            handler: nil
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("LocationManager didUpdateLocations: %@", locations)
        
        // handle updated location
        if (locations.count > 0) {
            latestLocation = locations.last!
            // latestLocation.coordinate.longitude
            // latestLocation.coordinate.latitude

            // TODO: remove all points from AR scene
            // TODO: add new points to AR scene
        }
    }
    
    // MARK: POIs
    
    func setupPOIs() {
        pois = []
        locationAnnotationNode2POI = [LocationTextAnnotationNode: PointOfInterest]()
        drawnLocationNodes = []
    }
    
    func getPOIs() {
        // formulate natural language query for nearby POIs
        for param in params {
            let request = MKLocalSearch.Request()
                   request.naturalLanguageQuery = param
        request.region = MKCoordinateRegion(center: (latestLocation?.coordinate)!,
                                            latitudinalMeters: 2000,
                                            longitudinalMeters: 2000)
        
        // getting POIs
        let search = MKLocalSearch(request: request)
        search.start {
            (response, error) in
            
            guard let response = response else {
                if let error = error {
                    // show alert with error and ok button for reset
                    print("Search error: \(error)")

                    self.presentConfirmationAlertViewWith(
                        title: "POIs Error",
                        message: "Could not fetch POIS near your current location.",
                        handler: { action in
                            self.resetARScene()
                    })
                }
                return
            }

            // add POIs to AR scene
            self.pois = []
            self.addPOIsToARScene(response.mapItems)
        }
    }
    }
    
    func addPOIsToARScene(_ items: [MKMapItem]) {
        for item in items {
            let location = CLLocation(coordinate: item.placemark.coordinate, altitude: 0)
            let distance = Int( round( self.latestLocation!.distance(from: location) ))
            if (distance <= 300) {
            let title = "\(item.placemark.name!)"
                let title2 = "\n\(distance) m"
            let poi = PointOfInterest(title: title,
                                      title2: title2,
                                      latitude: location.coordinate.latitude,
                                      longitude: location.coordinate.longitude,
                                      altitude: location.altitude)
            self.pois.append( poi)
            self.addPOIToARScene(poi)
        }
        }
    }
    
    // MARK: Directions
    
    func getRouteSegments(startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D) {
        
        // Request the directions between the two points
        let directionRequest = setupRouteDirectionsRequest(startCoordinate: startCoordinate, endCoordinate: endCoordinate)
        let directions = MKDirections(request: directionRequest)
        directions.calculate {
            (response, error) -> Void in
            
            guard let response = response else {
                if let error = error {
                    // Show alert with error and ok button for reset
                    print("Error: \(error)")

                    let poiString = self.selectedPOI?.title ?? "the POI"
                    self.presentConfirmationAlertViewWith(
                        title: "Directions Error",
                        message: "Could not fetch directions between your current location and \(poiString).",
                        handler: { action in
                            self.resetARScene()
                    })
                }
                return
            }

            // add route segments to AR Scene
            self.manageRouteDirections(response)
        }
    }
    
    func setupRouteDirectionsRequest(startCoordinate: CLLocationCoordinate2D, endCoordinate: CLLocationCoordinate2D) -> MKDirections.Request {
        let sourcePlacemark = MKPlacemark(coordinate: startCoordinate, addressDictionary: nil)
        let destinationPlacemark = MKPlacemark(coordinate: endCoordinate, addressDictionary: nil)
        
        // create the request for walking directions between the source and destination placemarks
        let directionRequest = MKDirections.Request()
        directionRequest.source = MKMapItem(placemark: sourcePlacemark)
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .walking
        
        return directionRequest
    }
    
    func manageRouteDirections(_ response: MKDirections.Response) {
        for route in response.routes {

            // add route coordinates together so we can build our AR path
            var routeCoordinates = [CLLocationCoordinate2D]()
            for step in route.steps {
                
                let pointCount = step.polyline.pointCount
                let stepCoordinates = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: pointCount)
                step.polyline.getCoordinates(stepCoordinates, range: NSRange(location: 0, length: pointCount))
                
                for i in 0..<pointCount {
                    routeCoordinates.append(stepCoordinates[i])
                }
            }

            // create and add the route segments to the AR scene
            for i in 0..<routeCoordinates.count-1 {

                let startCoordinate = routeCoordinates[i]
                let endCoordinate = routeCoordinates[i+1]
                let routeSegment = RouteSegment(startLatitude: startCoordinate.latitude, startLongitude: startCoordinate.longitude, startAltitude: 0,
                                                endLatitude: endCoordinate.latitude, endLongitude: endCoordinate.longitude, endAltitude: 0)
                self.addRouteSegmentToARScene(routeSegment)
            }
            
            // handle destination segment
            let finalStepCoordinate = routeCoordinates[routeCoordinates.count-1]
            let routeSegment = RouteSegment(startLatitude: finalStepCoordinate.latitude, startLongitude: finalStepCoordinate.longitude, startAltitude: 0,
                                            endLatitude: selectedPOI!.latitude, endLongitude: selectedPOI!.longitude, endAltitude: 0)
            self.addFinalRouteSegmentToARScene(routeSegment)
        }
    }
    
    // MARK: AR Scene
    
    func addPOIToARScene(_ poi: PointOfInterest) {
        // create node
        let location = CLLocation(latitude: poi.latitude, longitude: poi.longitude)
        let text = poi.title.replacingOccurrences(of: ", ", with: "\n")+poi.title2.replacingOccurrences(of: ", ", with: "\n")
        let annotationNode = LocationTextAnnotationNode(location: location, text: text)
        
        // add node to AR scene
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        drawnLocationNodes.append(annotationNode)
        locationAnnotationNode2POI[annotationNode] = poi
    }

    func addFinalRouteSegmentToARScene(_ routeSegment: RouteSegment) {
        // create start node
        let startLocation = CLLocation(latitude: routeSegment.startLatitude, longitude: routeSegment.startLongitude)
        let startNode = RouteAnnotationNode(location: startLocation)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: startNode)
        drawnLocationNodes.append(startNode)
        
        // add end node to AR scene
        self.addDestinationPOIToARScene(selectedPOI!)
        let endNode = drawnLocationNodes.last as! RouteAnnotationNode
        
        // add route segment node to AR scene
        let routeSegmentAnnotationNode = RouteSegmentAnnotationNode(startNode: startNode, endNode: endNode)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: routeSegmentAnnotationNode)
        drawnLocationNodes.append(routeSegmentAnnotationNode)
    }
    
    func addRouteSegmentToARScene(_ routeSegment: RouteSegment) {
        // add start node to AR scene
        let startLocation = CLLocation(latitude: routeSegment.startLatitude, longitude: routeSegment.startLongitude)
        let startNode = RouteAnnotationNode(location: startLocation)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: startNode)
        drawnLocationNodes.append(startNode)
        
        // add end node to AR scene
        let endLocation = CLLocation(latitude: routeSegment.endLatitude, longitude: routeSegment.endLongitude)
        let endNode = RouteAnnotationNode(location: endLocation)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: endNode)
        drawnLocationNodes.append(endNode)
        
        // add route segment node to AR scene
        let routeSegmentAnnotationNode = RouteSegmentAnnotationNode(startNode: startNode, endNode: endNode)
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: routeSegmentAnnotationNode)
        drawnLocationNodes.append(routeSegmentAnnotationNode)
    }
    
    func addDestinationPOIToARScene(_ poi: PointOfInterest) {
         let location = CLLocation(coordinate: CLLocationCoordinate2D(latitude: poi.latitude, longitude: poi.longitude), altitude: poi.altitude)
        let routeAnnotationNode = RouteAnnotationNode(location: location, color: .red)
        
        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: routeAnnotationNode)
        drawnLocationNodes.append(routeAnnotationNode)
    }
    
    func setupARScene() {
        // create AR scene
        sceneLocationView = SceneLocationView()
        view.addSubview(sceneLocationView)

        // add tap gesture recognizer to AR scene's view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleARObjectTap(gestureRecognizer:)))
        sceneLocationView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    
    
    func drawARScene() {
        
        if selectedPOI == nil {
            getPOIs()
            //getMorePOIs()
            //getLibraryPOI()
        }
        else {
            if latestLocation != nil {
                // get route segments
                getRouteSegments(startCoordinate: (latestLocation?.coordinate)!,
                                 endCoordinate: CLLocationCoordinate2D(latitude: (selectedPOI?.latitude)!,
                                                                       longitude: (selectedPOI?.longitude)!))
            }
            
        }
    }
    
    func clearNodesAndRedrawARScene() {

        for locationNode in drawnLocationNodes {
            sceneLocationView.removeLocationNode(locationNode: locationNode)
        }
        
        drawnLocationNodes = []
        toggleResetButtonStatus()
        drawARScene()
    }
    
    func resetARScene() {
        selectedPOI = nil
        clearNodesAndRedrawARScene()
    }
        


    // MARK: Alert views

    func presentConfirmationAlertViewWith(title: String, message: String, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        self.present(alert, animated: true, completion: nil)
    }
    func openPage(action: UIAlertAction) {
        showSafariVC(for: "https://www.csun.edu/")
    }
    func showSafariVC(for url: String) {
        guard let url = URL(string: url) else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }


    func presentPOIAlertViewfor(poi: PointOfInterest) {
        
        if poi.title == "UFC GYM Northridge" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.ufcgym.com/locations/northridge/")
        }))
        }
        /**********************************************************************/
        if poi.title == "Poseidon Lounge" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.yelp.com/biz/poseidon-lounge-northridge-3")
        }))
        }
        /**********************************************************************/
        if poi.title == "Subway" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "order.subway.com")
        }))
        }
        /**********************************************************************/
        if poi.title == "Starr Beauty" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.yelp.com/biz/starr-beauty-northridge")
        }))
        }
        /**********************************************************************/
        if poi.title == "Northridge Graphics & Printing Services" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.yelp.com/biz/northridge-copy-and-graphics-center-northridge-2")
        }))
        }
        /**********************************************************************/
        if poi.title == "Leo's Jewelry & Watch Repair" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.yelp.com/biz/leos-jewelry-and-watch-repair-northridge")
        }))
        }
        /**********************************************************************/
        if poi.title == "Northridge Stationery Copy Center" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.yelp.com/biz/northridge-copy-and-graphics-center-northridge-2")
        }))
        }
        /**********************************************************************/
        if poi.title == "Big 5 Sporting Goods" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.big5sportinggoods.com/store/")
        }))
        }
        /**********************************************************************/
        if poi.title == "Hookah Source" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.yelp.com/biz/hookah-source-northridge")
        }))
        }
        /**********************************************************************/
        if poi.title == "Homesmart" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://homesmart.com/")
        }))
        }
        /**********************************************************************/
        if poi.title == "T-Mobile" {
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
            self.selectedPOI = poi
            self.clearNodesAndRedrawARScene()
        }))
        //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.t-mobile.com/")
        }))
        }
        /**********************************************************************/
              if poi.title == "California Chicken Cafe" {
              let alert = UIAlertController(title: poi.title+poi.title2,
                                            message: "",
                                            preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true, completion: nil)

              alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
                  self.selectedPOI = poi
                  self.clearNodesAndRedrawARScene()
              }))
              //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
              alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
                  (action:UIAlertAction!) -> Void in
                  self.showSafariVC(for: "https://califchickencafe.com/")
              }))
              }
        /**********************************************************************/
              if poi.title == "Yoshinoya Nordhoff & Reseda" {
              let alert = UIAlertController(title: poi.title+poi.title2,
                                            message: "",
                                            preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true, completion: nil)

              alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
                  self.selectedPOI = poi
                  self.clearNodesAndRedrawARScene()
              }))
              //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
              alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
                  (action:UIAlertAction!) -> Void in
                  self.showSafariVC(for: "https://www.yoshinoyaamerica.com/")
              }))
              }
        /**********************************************************************/
              if poi.title == "Great Clips" {
              let alert = UIAlertController(title: poi.title+poi.title2,
                                            message: "",
                                            preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true, completion: nil)

              alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
                  self.selectedPOI = poi
                  self.clearNodesAndRedrawARScene()
              }))
              //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
              alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
                  (action:UIAlertAction!) -> Void in
                  self.showSafariVC(for: "https://www.greatclips.com/")
              }))
              }
        /**********************************************************************/
              if poi.title == "Fishbowl Poke Co" {
              let alert = UIAlertController(title: poi.title+poi.title2,
                                            message: "",
                                            preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true, completion: nil)

              alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
                  self.selectedPOI = poi
                  self.clearNodesAndRedrawARScene()
              }))
              //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
              alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
                  (action:UIAlertAction!) -> Void in
                  self.showSafariVC(for: "https://www.fishbowlpokeco.com/")
              }))
              }
        /**********************************************************************/
              if poi.title == "Panda Express" {
              let alert = UIAlertController(title: poi.title+poi.title2,
                                            message: "",
                                            preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true, completion: nil)

              alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
                  self.selectedPOI = poi
                  self.clearNodesAndRedrawARScene()
              }))
              //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
              alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
                  (action:UIAlertAction!) -> Void in
                  self.showSafariVC(for: "https://www.pandaexpress.com/")
              }))
              }
        /**********************************************************************/
              if poi.title == "Futaba" {
              let alert = UIAlertController(title: poi.title+poi.title2,
                                            message: "",
                                            preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true, completion: nil)

              alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
                  self.selectedPOI = poi
                  self.clearNodesAndRedrawARScene()
              }))
              //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
              alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
                  (action:UIAlertAction!) -> Void in
                  self.showSafariVC(for: "https://www.yelp.com/biz/futaba-japanese-restaurant-northridge")
              }))
              }
        /**********************************************************************/
              if poi.title == "WaBa Grill" {
              let alert = UIAlertController(title: poi.title+poi.title2,
                                            message: "",
                                            preferredStyle: .alert)
              alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
              self.present(alert, animated: true, completion: nil)

              alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
                
                self.selectedPOI = poi
                  self.clearNodesAndRedrawARScene()
              }))
              //alert.addAction(UIAlertAction(title: "Website", style: .default, handler: openPage))
              alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
                  (action:UIAlertAction!) -> Void in
                  self.showSafariVC(for: "https://www.wabagrill.com/")
              }))
              }
              else {
        
        let alert = UIAlertController(title: poi.title+poi.title2,
                                      message: "",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)

        alert.addAction(UIAlertAction(title: "Get directions", style: .default, handler: { action in
          
          self.selectedPOI = poi
          self.clearNodesAndRedrawARScene()
        }))
        

        //
        alert.addAction(UIAlertAction(title: "Website", style: .default, handler:  {
            (action:UIAlertAction!) -> Void in
            self.showSafariVC(for: "https://www.csun.edu/")
        }))
        
        }
        
    }
    }

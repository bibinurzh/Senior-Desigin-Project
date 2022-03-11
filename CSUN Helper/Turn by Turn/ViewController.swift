import UIKit
import MapKit
import CoreLocation
import AVFoundation

class CustomPointAnnotation: MKPointAnnotation{
    var imageName: String!
}


class ViewController: UIViewController  {
    @IBOutlet weak var restaurantLabel: UIButton!
    @IBOutlet weak var museumLabel: UIButton!
    @IBOutlet weak var TheathersLabel: UIButton!
    @IBOutlet weak var hotelLabel: UIButton!
    @IBOutlet weak var storeLabel: UIButton!
    @IBOutlet weak var gymLabel: UIButton!
    @IBOutlet weak var onoffLabel: UIButton!
    @IBOutlet weak var schoolLabel: UIButton!
    @IBOutlet weak var bankLabel: UIButton!
    @IBOutlet weak var parkLabel: UIButton!
    @IBOutlet weak var gasLabel: UIButton!
    @IBOutlet weak var lecLabel: UIButton!
    @IBOutlet weak var librariesLabel: UIButton!
    
    var jacarandaPin = CustomPointAnnotation()
    var libraryPin = CustomPointAnnotation()
    var bayramianPin = CustomPointAnnotation()
    var liveOakPin = CustomPointAnnotation()
    var sequoiaPin = CustomPointAnnotation()
    var chaparralPin = CustomPointAnnotation()
    var eucalyptusPin = CustomPointAnnotation()
    var citrusPin = CustomPointAnnotation()
    var booksteinPin = CustomPointAnnotation()
    var cypressPin = CustomPointAnnotation()
    var nordhoffPin = CustomPointAnnotation()
    var redwoodPin = CustomPointAnnotation()
    var valleyPin = CustomPointAnnotation()
    var sagebrushPin = CustomPointAnnotation()
    var sierraPin = CustomPointAnnotation()
    var srcPin = CustomPointAnnotation()
    var usuPin = CustomPointAnnotation()
    var wabaPin = CustomPointAnnotation()
    var ufcGymPin = CustomPointAnnotation()
    var dearbparkPin = CustomPointAnnotation()
    var northridgePacificTheaterPin = CustomPointAnnotation()
    var sanfernMuseumPin = CustomPointAnnotation()
    var lilfreeLibraryPin = CustomPointAnnotation()
    var northridgemiddleSchoolPin = CustomPointAnnotation()
    var northridgeunicenterPin = CustomPointAnnotation()
    var wellsfargoPin = CustomPointAnnotation()
    var gas76Pin = CustomPointAnnotation()
    //plaza
    var big5 = CustomPointAnnotation()
    var boba = CustomPointAnnotation()
    var california = CustomPointAnnotation()
    var fishbowl = CustomPointAnnotation()
    var futaba = CustomPointAnnotation()
    var greatclips = CustomPointAnnotation()
    var homesmart = CustomPointAnnotation()
    var hookah = CustomPointAnnotation()
    var leo = CustomPointAnnotation()
    var stationary = CustomPointAnnotation()
    var graphic = CustomPointAnnotation()
    var panda = CustomPointAnnotation()
    var poseidon = CustomPointAnnotation()
    var starbeauty = CustomPointAnnotation()
    var subway = CustomPointAnnotation()
    var tmobile = CustomPointAnnotation()
    var yoshinoya = CustomPointAnnotation()
    
    
    var eduPins: [CustomPointAnnotation] = []
    var gasPins: [CustomPointAnnotation] = []
    var restaurantPins: [CustomPointAnnotation] = []
    var libraryPins: [CustomPointAnnotation] = []
    var parkPins: [CustomPointAnnotation] = []
    var hotelPins: [CustomPointAnnotation] = []
    var schoolPins: [CustomPointAnnotation] = []
    var mallPins: [CustomPointAnnotation] = []
    var bankPins: [CustomPointAnnotation] = []
    var moviePins: [CustomPointAnnotation] = []
    var museumPins: [CustomPointAnnotation] = []
    var gymPins: [CustomPointAnnotation] = []
    
    var optionString = ""
   
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var matadorLocation: UIButton!
    
    var menuOut = false
    var lec = false
    var res = false
    var gas = false
    var lib = false
    var hot = false
    var par = false
    var sch = false
    var mal = false
    var ban = false
    var mov = false
    var mus = false
    var gym = false
    var the = false
    
    var eduOn = false
    var gasOn = false
    var resOn = false
    var libOn = false
    var parOn = false
    var hotOn = false
    var schOn = false
    var malOn = false
    var banOn = false
    var movOn = false
    var musOn = false
    var gymOn = false
    var OnOffOn = false
    
    
    func turnOnPins(_ buildingPins: [CustomPointAnnotation]){
        for pin in buildingPins {
            //mapView.addAnnotation(pins.title() as !MKAnnotation)
            mapView.addAnnotation(pin)
        }
    }
    
    func turnOffPins(_ buildingPins:[CustomPointAnnotation]){
        for pin in buildingPins {
            mapView.removeAnnotation(pin)
        }
    }
    
    @IBAction func camera(_ sender: Any) {
        
        if lec {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Lecture Halls"]
            present(sb, animated: true, completion: nil)
            res = false
            gas = false
            lib = false
            hot = false
            par = false
            sch = false
            ban = false
            mus = false
            the = false
            mal = false
            gym = false
            
        }
        if res {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Restaurants"]
            present(sb, animated: true, completion: nil)
            lec = false
            gas = false
            lib = false
            hot = false
            par = false
            sch = false
            ban = false
            mus = false
            the = false
            mal = false
            gym = false
            
        }
        if gas {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Gas Stations"]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            lib = false
            hot = false
            par = false
            sch = false
            ban = false
            mus = false
            the = false
            mal = false
            gym = false
            
        }
        if lib {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Libraries"]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            gas = false
            hot = false
            par = false
            sch = false
            ban = false
            mus = false
            the = false
            mal = false
            gym = false
            
        }
        if hot{
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Hotels"]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            gas = false
            lib = false
            par = false
            sch = false
            ban = false
            mus = false
            the = false
            mal = false
            gym = false
            
            
        }
        if par{
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Parks"]
            lec = false
            res = false
            gas = false
            lib = false
            hot = false
            sch = false
            ban = false
            mus = false
            the = false
            mal = false
            gym = false
            
            
        }
        if sch {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Schools"]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            gas = false
            lib = false
            hot = false
            hot = false
            par = false
            ban = false
            mus = false
            the = false
            mal = false
            gym = false
            
        }
        if ban {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Banks"]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            gas = false
            lib = false
            hot = false
            par = false
            sch = false
            mus = false
            the = false
            mal = false
            gym = false
        }
        if mus {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Museums"]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            gas = false
            lib = false
            hot = false
            par = false
            ban = false
            sch = false
            the = false
            mal = false
            gym = false
        }
        if the {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Theaters"]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            gas = false
            lib = false
            hot = false
            par = false
            ban = false
            mus = false
            sch = false
            mal = false
            gym = false
        }
        if mal {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Malls"]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            gas = false
            lib = false
            hot = false
            par = false
            ban = false
            mus = false
            the = false
            sch = false
            gym = false
        }
        if gym {
            let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Gyms"]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            gas = false
            lib = false
            hot = false
            par = false
            ban = false
            mus = false
            the = false
            mal = false
            sch = false
        }
        let sb = storyboard?.instantiateViewController(withIdentifier: "viewcontroller2") as! ARCLViewController
            sb.params = ["Restaurants", "Gas Stations", "Lecture Halls", "Schools", "Parks", "Hotels", "Libraries", "Banks", "Theaters", "Museums", "Malls", "Gyms" ]
            present(sb, animated: true, completion: nil)
            lec = false
            res = false
            gas = false
            lib = false
            hot = false
            hot = false
            par = false
            sch = false
            ban = false
            mus = false
            the = false
            mal = false
            gym = false
        }
    @IBAction func matadorClicked(_ sender: Any) {
        userLocation()
    }
    
    @IBAction func educationalClicked(_ sender: Any) {
        //need to test
        if (eduOn == false){
            optionString = "Educational Building"
            turnOnPins(eduPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            lec = true
            eduOn = true
            lecLabel.setTitleColor(UIColor.gray, for: .normal)
        }
        else {
            optionString = ""
            turnOffPins(eduPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            lec = false
            eduOn = false
            lecLabel.setTitleColor(UIColor.red, for: .normal)
        }
        
    }
    
    @IBAction func gasClicked(_ sender: Any) {
        if (gasOn == false){
            optionString = "Gas Station"
            turnOnPins(gasPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            gas = true
            gasOn = true
            gasLabel.setTitleColor(UIColor.gray, for: .normal)
        }
        else {
            optionString = ""
            turnOffPins(gasPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            gas = false
            gasOn = false
            gasLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func restaurantClicked(_ sender: Any) {
        if (resOn == false){
            optionString = "Restaurant"
            turnOnPins(restaurantPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            res = true
            resOn = true
            restaurantLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(restaurantPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            res = false
            resOn = false
            restaurantLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func librarytClicked(_ sender: Any) {
        if (libOn == false) {
            optionString = "Libraries"
            turnOnPins(libraryPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            lib = true
            libOn = true
            librariesLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(libraryPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            lib = false
            libOn = false
            librariesLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func parkClicked(_ sender: Any) {
        if (parOn == false){
            optionString = "Parks"
            turnOnPins(parkPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            par = true
            parOn = true
            parkLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(parkPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            par = false
            parOn = false
            parkLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func HotelClicked(_ sender: Any) {
        if (hotOn == false) {
            optionString = "Hotels"
            turnOnPins(hotelPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            hot = true
            hotOn = true
            hotelLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(hotelPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            hot = false
            hotOn = false
            hotelLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func schoolClicked(_ sender: Any) {
        if (schOn == false) {
            optionString = "Schools"
            turnOnPins(schoolPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            sch = true
            schOn = true
            schoolLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(schoolPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            sch = false
            schOn = false
            schoolLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func mallsClicked(_ sender: Any) {
        if(malOn == false){
           optionString = "Malls"
           turnOnPins(mallPins)
           leading.constant = -30
           trailing.constant = 0
           menuOut = false
           mal = true
           malOn = true
           storeLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(mallPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            mal = false
            malOn = false
            storeLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func banksClicked(_ sender: Any) {
        if (banOn == false){
           optionString = "Banks"
           turnOnPins(bankPins)
           leading.constant = -30
           trailing.constant = 0
           menuOut = false
           ban = true
           banOn = true
           bankLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(bankPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            ban = false
            banOn = false
            bankLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func movieTClicked(_ sender: Any) {
        if (movOn == false){
           optionString = "Movie Theathers"
           turnOnPins(moviePins)
           leading.constant = -30
           trailing.constant = 0
           menuOut = false
           mov = true
           movOn = true
           TheathersLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(moviePins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            mov = false
            movOn = false
            TheathersLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func MuseumClicked(_ sender: Any) {
        if (musOn == false){
           optionString = "Museums"
           turnOnPins(museumPins)
           leading.constant = -30
           trailing.constant = 0
           menuOut = false
           mus = true
           musOn = true
           museumLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(museumPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            mus = false
            musOn = false
            museumLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func GymsClicked(_ sender: Any) {
        if (gymOn == false){
           optionString = "Gyms"
           turnOnPins(gymPins)
           leading.constant = -30
           trailing.constant = 0
           menuOut = false
           gym = true
           gymOn = true
           gymLabel.setTitleColor(UIColor.gray, for: .normal)
        } else {
            optionString = ""
            turnOffPins(gymPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            gym = false
            gymOn = false
            gymLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
//    @IBOutlet weak var restaurantLabel: UIButton!
//    @IBOutlet weak var museumLabel: UIButton!
//    @IBOutlet weak var TheathersLabel: UIButton!
//    @IBOutlet weak var hotelLabel: UIButton!
//    @IBOutlet weak var storeLabel: UIButton!
//    @IBOutlet weak var gymLabel: UIButton!
//    @IBOutlet weak var onoffLabel: UIButton!
//    @IBOutlet weak var schoolLabel: UIButton!
//    @IBOutlet weak var bankLabel: UIButton!
//    @IBOutlet weak var parkLabel: UIButton!
//    @IBOutlet weak var gasLabel: UIButton!
//    @IBOutlet weak var lecLabel: UIButton!
//    @IBOutlet weak var librariesLabel: UIButton!
    
    @IBAction func OnOffClicked(_ sender: Any) {
        if (OnOffOn == false){
           optionString = ""
           turnOnPins(eduPins)
           turnOnPins(gasPins)
           turnOnPins(restaurantPins)
           turnOnPins(libraryPins)
           turnOnPins(parkPins)
           turnOnPins(hotelPins)
           turnOnPins(schoolPins)
           turnOnPins(mallPins)
           turnOnPins(bankPins)
           turnOnPins(moviePins)
           turnOnPins(museumPins)
           turnOnPins(gymPins)
           leading.constant = -30
           trailing.constant = 0
           menuOut = false
           OnOffOn = true
           onoffLabel.setTitleColor(UIColor.gray, for: .normal)
           restaurantLabel.setTitleColor(UIColor.gray, for: .normal)
           museumLabel.setTitleColor(UIColor.gray, for: .normal)
           TheathersLabel.setTitleColor(UIColor.gray, for: .normal)
           hotelLabel.setTitleColor(UIColor.gray, for: .normal)
           gymLabel.setTitleColor(UIColor.gray, for: .normal)
           schoolLabel.setTitleColor(UIColor.gray, for: .normal)
           bankLabel.setTitleColor(UIColor.gray, for: .normal)
           parkLabel.setTitleColor(UIColor.gray, for: .normal)
           gasLabel.setTitleColor(UIColor.gray, for: .normal)
           lecLabel.setTitleColor(UIColor.gray, for: .normal)
           librariesLabel.setTitleColor(UIColor.gray, for: .normal)
           storeLabel.setTitleColor(UIColor.gray, for: .normal)
            
        } else {
            optionString = ""
            turnOffPins(eduPins)
            turnOffPins(gasPins)
            turnOffPins(restaurantPins)
            turnOffPins(libraryPins)
            turnOffPins(parkPins)
            turnOffPins(hotelPins)
            turnOffPins(schoolPins)
            turnOffPins(mallPins)
            turnOffPins(bankPins)
            turnOffPins(moviePins)
            turnOffPins(museumPins)
            turnOffPins(gymPins)
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
            OnOffOn = false
            onoffLabel.setTitleColor(UIColor.red, for: .normal)
            storeLabel.setTitleColor(UIColor.red, for: .normal)
            restaurantLabel.setTitleColor(UIColor.red, for: .normal)
            museumLabel.setTitleColor(UIColor.red, for: .normal)
            TheathersLabel.setTitleColor(UIColor.red, for: .normal)
            hotelLabel.setTitleColor(UIColor.red, for: .normal)
            gymLabel.setTitleColor(UIColor.red, for: .normal)
            schoolLabel.setTitleColor(UIColor.red, for: .normal)
            bankLabel.setTitleColor(UIColor.red, for: .normal)
            parkLabel.setTitleColor(UIColor.red, for: .normal)
            gasLabel.setTitleColor(UIColor.red, for: .normal)
            lecLabel.setTitleColor(UIColor.red, for: .normal)
            librariesLabel.setTitleColor(UIColor.red, for: .normal)
        }
    }
    
    @IBAction func menuOptions(_ sender: Any) {
        if menuOut == false{
            leading.constant = 170
            trailing.constant = -170
            menuOut = true
        }
        else{
            leading.constant = -30
            trailing.constant = 0
            menuOut = false
        }
    }
    

    
    
    let locationManager = CLLocationManager()
    var currentCoordinate: CLLocationCoordinate2D!
    
    var steps = [MKRoute.Step]()
    let speechSynthesizer = AVSpeechSynthesizer()
    
    var stepCounter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self

        restaurantLabel.setTitleColor(UIColor.red, for: .normal)
        museumLabel.setTitleColor(UIColor.red, for: .normal)
        TheathersLabel.setTitleColor(UIColor.red, for: .normal)
        hotelLabel.setTitleColor(UIColor.red, for: .normal)
        storeLabel.setTitleColor(UIColor.red, for: .normal)
        gymLabel.setTitleColor(UIColor.red, for: .normal)
        onoffLabel.setTitleColor(UIColor.red, for: .normal)
        schoolLabel.setTitleColor(UIColor.red, for: .normal)
        bankLabel.setTitleColor(UIColor.red, for: .normal)
        parkLabel.setTitleColor(UIColor.red, for: .normal)
        gasLabel.setTitleColor(UIColor.red, for: .normal)
        lecLabel.setTitleColor(UIColor.red, for: .normal)
        librariesLabel.setTitleColor(UIColor.red, for: .normal)
        
        
        
        
        let distanceSpan: CLLocationDegrees = 500
        let bsCSUNCAmpusLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(34.241464890869224, -118.52937457790358)
        mapView.setRegion(MKCoordinateRegion(center: bsCSUNCAmpusLocation, latitudinalMeters: distanceSpan, longitudinalMeters: distanceSpan), animated: true)
        
       
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()

        //Possible function to make this all easier, need to test.
        
        func setPins(longitude: Double, latitude: Double, locationPin: CustomPointAnnotation, locationName: String, locationImage: String){
            let locationCoordinates = CLLocationCoordinate2DMake(longitude, latitude)
            locationPin.coordinate = locationCoordinates
            locationPin.title = locationName
            locationPin.imageName = locationImage
           
        }
        
        setPins(longitude: 34.241153, latitude: -118.528926, locationPin: jacarandaPin, locationName: "Jacaranda Hall", locationImage: "Jacaranda Hall.png")
       
        
        setPins(longitude: 34.240032, latitude: -118.529318, locationPin: libraryPin, locationName: "Oviatt Library", locationImage: "oviatt.png")
       
        
        setPins(longitude: 34.240479, latitude: -118.530862, locationPin: bayramianPin, locationName: "Bayramian Hall", locationImage: "bayramian.png")
        
        setPins(longitude: 34.238448, latitude: -118.528219, locationPin: liveOakPin, locationName: "Live Oak Hall", locationImage: "live oak.png")
        
        setPins(longitude: 34.240639, latitude: -118.528243, locationPin: sequoiaPin, locationName: "Sequia Hall", locationImage: "sequia.png")
        
        setPins(longitude: 34.23842, latitude: -118.527128, locationPin: chaparralPin, locationName: "Chaparral Hall", locationImage: "chaparall.png")
        
        setPins(longitude: 34.239096, latitude: -118.528073, locationPin: citrusPin, locationName: "Citrus Hall", locationImage: "citrus.png")
        
        setPins(longitude: 34.238730, latitude: -118.528118, locationPin: eucalyptusPin, locationName: "Eucalyptus Hall", locationImage: "Eucalyptus.png")
        
        setPins(longitude: 34.242014, latitude: -118.530814, locationPin: booksteinPin, locationName: "Bookstein Hall", locationImage: "bookstein.png")
        
        setPins(longitude: 34.23619, latitude: -118.529698, locationPin: cypressPin, locationName: "Cypress Hall", locationImage: "cypress.png")
        
        setPins(longitude: 34.236381, latitude: -118.530644, locationPin: nordhoffPin, locationName: "Nordhoff Hall", locationImage: "nordhoff.png")
        
        setPins(longitude: 34.242042, latitude: -118.526355, locationPin: redwoodPin, locationName: "Redwood Hall", locationImage: "redwood.png")
        
        setPins(longitude: 34.235926, latitude: -118.528006, locationPin: valleyPin, locationName: "Younes and Soraya Nazarian Center for the Performing Arts", locationImage: "valley.png")
        
        setPins(longitude: 34.242549, latitude: -118.528469, locationPin: sagebrushPin, locationName: "Sagebrush Hall", locationImage: "sagebrush.png")
        
        
        setPins(longitude: 34.238220, latitude: -118.530790, locationPin: sierraPin, locationName: "Sierra Hall", locationImage: "sierra.png")
        
        
        setPins(longitude: 34.239856, latitude: -118.524904, locationPin: srcPin, locationName: "Student Recreation Center", locationImage: "src.png")
        
        
        setPins(longitude: 34.240049, latitude: -118.525809, locationPin: usuPin, locationName: "University Student Union", locationImage: "usu.png")
        
        
        setPins(longitude: 34.2358, latitude: -118.5348, locationPin: wabaPin, locationName: "WaBa Grill", locationImage: "WaBa Grill.png")
        
        //        wabaPin.imageName = "*insert waba grill photo*"
        
        setPins(longitude: 34.236874, latitude: -118.535390, locationPin: ufcGymPin, locationName: "UFC GYM Northridge", locationImage: "UFC GYM Northridge.png")
        
        setPins(longitude: 34.2374, latitude: -118.5079, locationPin: dearbparkPin, locationName: "Dearborn Park", locationImage: "Jacaranda Hall.png")
        
        
        setPins(longitude: 34.2412, latitude: -118.5579, locationPin: northridgePacificTheaterPin, locationName: "Northridge Pacific Theaters", locationImage: "Jacaranda Hall.png")
        
        setPins(longitude: 34.2355, latitude: -118.5443, locationPin: sanfernMuseumPin, locationName: "The Musuem of the San Fernando Valley", locationImage: "Jacaranda Hall.png")
        //mapView.addAnnotation(sanfernMuseumPin)
        
        setPins(longitude: 34.2295, latitude: -118.5671, locationPin: lilfreeLibraryPin, locationName: "Little Free Library", locationImage: "Jacarand Hall.png")
        
        
        setPins(longitude: 34.2246, latitude: -118.5234, locationPin: northridgemiddleSchoolPin, locationName: "Northirdge Middle School", locationImage: "Jacranda Hall.png")
        
        setPins(longitude: 34.2367, latitude: -118.5370, locationPin: northridgeunicenterPin, locationName: "Northridge University Center", locationImage: "Jacaranda Hall.png")
        
        
        setPins(longitude: 34.2399, latitude: -118.5264, locationPin: wellsfargoPin, locationName: "Wells Fargo Bank", locationImage: "Jacaranda Hall.png")
        //mapView.addAnnotation(wellsfargoPin)
        
        
        setPins(longitude: 34.2357, latitude: -118.5272, locationPin: gas76Pin, locationName: "76", locationImage: "Jacaranda Hall.png")
        
        setPins(longitude: 34.236207, latitude: -118.535473, locationPin: big5, locationName: "Big 5 Sporting Goods", locationImage: "Big 5 Sporting Goods.png")
        
        setPins(longitude: 34.235730, latitude: -118.534736, locationPin: boba, locationName: "Boba My Tea", locationImage: "Boba My Tea.png")
        
        setPins(longitude: 34.235992, latitude: -118.535245, locationPin: california, locationName: "California Chicken Cafe", locationImage: "California Chicken Cafe.png")

        setPins(longitude: 34.235737, latitude: -118.534801, locationPin: fishbowl, locationName: "Fishbowl Poke Co", locationImage: "Fishbowl Poke Co.png")
        
        setPins(longitude: 34.235886, latitude: -118.534742, locationPin: greatclips, locationName: "Great Clips", locationImage: "Great Clips.png")
        
        setPins(longitude: 34.235695, latitude: -118.534819, locationPin: futaba, locationName: "Futaba", locationImage: "Futaba.png")
        
        setPins(longitude: 34.236124, latitude: -118.535164, locationPin: homesmart, locationName: "Homesmart", locationImage: "Homesmart.png")
        
        setPins(longitude: 34.236100, latitude: -118.535529, locationPin: hookah, locationName: "Hookah Source", locationImage: "Hookah Source.png")
        
        setPins(longitude: 34.236588, latitude: -118.535479, locationPin: leo, locationName: "Leo's Jewelery", locationImage: "Leo's Jewelery.png")
        
        setPins(longitude: 34.236429, latitude: -118.535454, locationPin: stationary, locationName: "Northridge Stationery Center", locationImage: "Northridge Stationery Copy Center.png")
        
        setPins(longitude: 34.236633, latitude: -118.535320, locationPin: graphic, locationName: "Northridge Graphics and Printing Services", locationImage: "Northridge_Graphic.png")
        
        setPins(longitude: 34.239872, latitude: -118.526231, locationPin: panda, locationName: "Panda Express", locationImage: "Panda Express.png")
        
        setPins(longitude: 34.236988, latitude: -118.534867, locationPin: poseidon, locationName: "Poseidon Restaurant", locationImage: "Poseidon_restaurant_lounge.png")
       
        setPins(longitude: 34.236775, latitude: -118.535407, locationPin: starbeauty, locationName: "Starr Beauty", locationImage: "starrBeauty.png")
        
        setPins(longitude: 34.237103, latitude: -118.535347, locationPin: subway, locationName: "Subway", locationImage: "subway.png")
        
        setPins(longitude: 34.235987, latitude: -118.535367, locationPin: tmobile, locationName: "T-Mobile", locationImage: "T-Mobile.png")
        
        setPins(longitude: 34.235992, latitude: -118.535082, locationPin: yoshinoya, locationName: "Yoshinoya", locationImage: "Yoshinoya Nordhoff & Reseda.png")
        
        
        mallPins.append(big5)
        mallPins.append(greatclips)
        mallPins.append(homesmart)
        mallPins.append(leo)
        mallPins.append(stationary)
        mallPins.append(graphic)
        mallPins.append(starbeauty)
        mallPins.append(tmobile)
        restaurantPins.append(boba)
        restaurantPins.append(subway)
        restaurantPins.append(california)
        restaurantPins.append(fishbowl)
        restaurantPins.append(futaba)
        restaurantPins.append(panda)
        restaurantPins.append(poseidon)
        restaurantPins.append(yoshinoya)
        
//        var yoshinoya = CustomPointAnnotation()
        
        
//        let jacarandaCoordinates = CLLocationCoordinate2DMake(34.241153, -118.528926)
//        jacarandaPin.coordinate = jacarandaCoordinates
//        jacarandaPin.title = "Jacaranda Hall"
//        jacarandaPin.imageName = "Jacaranda Hall.png"
        eduPins.append(jacarandaPin)
        //mapView.addAnnotation(jacarandaPin)

        eduPins.append(libraryPin)
        eduPins.append(bayramianPin)
 
        eduPins.append(liveOakPin)
        eduPins.append(sequoiaPin)
        eduPins.append(chaparralPin)
        eduPins.append(citrusPin)
        eduPins.append(eucalyptusPin)
        eduPins.append(booksteinPin)
        eduPins.append(cypressPin)
        eduPins.append(nordhoffPin)
        eduPins.append(redwoodPin)
        eduPins.append(valleyPin)
        eduPins.append(sagebrushPin)
        eduPins.append(sierraPin)
        eduPins.append(srcPin)
        eduPins.append(usuPin)
        restaurantPins.append(wabaPin)
        gymPins.append(ufcGymPin)
        parkPins.append(dearbparkPin)
        libraryPins.append(lilfreeLibraryPin)
        schoolPins.append(northridgemiddleSchoolPin)
        gasPins.append(gas76Pin)
        
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if !(annotation is MKPointAnnotation){
            print("Not registered")
            return nil
        }
        var annotationvView = mapView.dequeueReusableAnnotationView(withIdentifier: "csunmapIdentifier")
        if annotationvView == nil{
            annotationvView = MKAnnotationView(annotation: annotation, reuseIdentifier: "csunmapIdentifier")
            annotationvView!.canShowCallout = true
        }
        else{
            annotationvView!.annotation = annotation
        }
        let cpa = annotation as! CustomPointAnnotation
        annotationvView!.image = UIImage(named: cpa.imageName)
        return annotationvView
    }
    
    func getDirections(to destination: MKMapItem) {
        
        let sourcePlacemark = MKPlacemark(coordinate: currentCoordinate)
        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
        let directionsRequest = MKDirections.Request()
        directionsRequest.source = sourceMapItem
        directionsRequest.destination = destination
        directionsRequest.transportType = .walking
        steps =  [MKRoute.Step]()
        let directions = MKDirections(request: directionsRequest)
        directions.calculate { (response, _) in
            guard let response = response else { return }
            guard let primaryRoute = response.routes.first else { return }
            
            self.mapView.addOverlay(primaryRoute.polyline)
            
        self.locationManager.monitoredRegions.forEach({ self.locationManager.stopMonitoring(for: $0) })
            
            self.steps = primaryRoute.steps
            for i in 0 ..< primaryRoute.steps.count {
                let step = primaryRoute.steps[i]
                print(step.instructions)
                print(step.distance)
                let region = CLCircularRegion(center: step.polyline.coordinate,
                                              radius: 20,
                                              identifier: "\(i)")
                self.locationManager.startMonitoring(for: region)
                let circle = MKCircle(center: region.center, radius: region.radius)
                self.mapView.addOverlay(circle)
            }
            
            let initialMessage = "In \(self.steps[0].distance) meters, \(self.steps[0].instructions) \(self.steps[1].instructions)."
            let speechUtterance = AVSpeechUtterance(string: initialMessage)
            self.speechSynthesizer.speak(speechUtterance)
            self.stepCounter += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
               super.didReceiveMemoryWarning()
               // Dispose of any resources that can be recreated.
           }
          
           private func userLocation(){
               guard let coordinate = locationManager.location?.coordinate else{return}
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
               mapView.setRegion(region, animated: true)
           }
           
           private func beginLocationUpdates(locationManager: CLLocationManager) {
               mapView.showsUserLocation = true
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.startUpdatingLocation()
           }
           
           private func zoomToLatestLocation(with coordinate: CLLocationCoordinate2D) {
            let zoomRegion = MKCoordinateRegion(center: coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
               mapView.setRegion(zoomRegion, animated: true)
           }
       

}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        manager.stopUpdatingLocation()
        guard let currentLocation = locations.first else { return }
        currentCoordinate = currentLocation.coordinate
        mapView.userTrackingMode = .followWithHeading
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("ENTERED")
        stepCounter += 1
        if stepCounter < steps.count {
            let currentStep = steps[stepCounter]
            let message = "In \(currentStep.distance) meters, \(currentStep.instructions)"
            let speechUtterance = AVSpeechUtterance(string: message)
            speechSynthesizer.speak(speechUtterance)
        } else {
            let message = "Arrived at destination"
            let speechUtterance = AVSpeechUtterance(string: message)
            speechSynthesizer.speak(speechUtterance)
            stepCounter = 0
            locationManager.monitoredRegions.forEach({ self.locationManager.stopMonitoring(for: $0) })
            
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.mapView.removeOverlays(mapView.overlays)
        searchBar.endEditing(true)
        let localSearchRequest = MKLocalSearch.Request()
        localSearchRequest.naturalLanguageQuery = searchBar.text
        let region = MKCoordinateRegion(center: currentCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        localSearchRequest.region = region
        userLocation()
        let localSearch = MKLocalSearch(request: localSearchRequest)
        localSearch.start { (response, _) in
            guard let response = response else { return }
            guard let firstMapItem = response.mapItems.first else { return }
            self.getDirections(to: firstMapItem)
        }
        
    }
}

extension ViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            renderer.strokeColor = .red
            renderer.lineWidth = 10
            return renderer
        }
        if overlay is MKCircle {
            let renderer = MKCircleRenderer(overlay: overlay)
            renderer.strokeColor = .black
            renderer.fillColor = .red
            renderer.alpha = 0.5
            return renderer
        }
        return MKOverlayRenderer()
    }
}


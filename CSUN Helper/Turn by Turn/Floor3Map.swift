

import UIKit

class Floor3Map: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var scrollview: UIScrollView!
    
    @IBOutlet weak var floor3map: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.scrollview.minimumZoomScale = 1.0
        self.scrollview.maximumZoomScale = 6.0
    }
    
    
    func viewForZooming(in scrollview: UIScrollView) -> UIView? {
        return self.floor3map
        
    }
    
    
    
}



import UIKit

class Floor2Map: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var floor2image: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.scrollView.minimumZoomScale = 1.0
        self.scrollView.maximumZoomScale = 6.0
    }
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.floor2image
        
    }
    
    
}

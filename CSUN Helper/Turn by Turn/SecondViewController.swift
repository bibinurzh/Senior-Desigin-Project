

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet var floorButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func handleSelection(_ sender: UIButton) {
        floorButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations: {
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })

        }
        
    }
    
    enum Floor: String {
        case floor1 = "Floor 1"
        case floor2 = "Floor 2"
        case floor3 = "Floor 3"
        case floor4 = "Floor 4"
    }
    
    @IBAction func floorTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let floor =  Floor(rawValue: title) else {
            return
        }
        
        switch floor{
        case .floor1:
            print("Floor 1")
        case .floor2:
            print("Floor 2")
        case .floor3:
            print("Floor 3")
        case .floor4:
            print("Floor 4")
        }
    }
}


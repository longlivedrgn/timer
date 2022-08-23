

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var normalRamenButton: UIButton!
    
    @IBOutlet weak var timeButton: UIButton!
    
    @IBOutlet weak var longRamenButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        normalRamenButton.layer.masksToBounds = true
        normalRamenButton.layer.cornerRadius = normalRamenButton.layer.frame.size.width/2
        timeButton.layer.masksToBounds = true
        timeButton.layer.cornerRadius = timeButton.layer.frame.size.width/2
        longRamenButton.layer.masksToBounds = true
        longRamenButton.layer.cornerRadius = longRamenButton.layer.frame.size.width/2
        
        navigationItem.title = "Click What U Want"
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func normalRamenButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "NormalRamen", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "NormalRamenViewController") as! NormalRamenViewController
        
        vc.title = "일반 라면"
        
        navigationController?.pushViewController(vc, animated: true)

    }
    @IBAction func stopwatchButtonTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "StopWatchDetail", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "StopWatchDetailViewController") as! StopWatchDetailViewController
        
        vc.title = "설정하기"
        
        navigationController?.pushViewController(vc, animated: true)
    }
}


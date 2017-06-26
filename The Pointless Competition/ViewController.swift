
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var score: UILabel!
    
    var scoreCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        btn.layer.cornerRadius = 107
        btn.clipsToBounds = true
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let newVC: ScoreBoardTVC = segue.destination as! ScoreBoardTVC
        newVC.receivedCount = scoreCount
    }
    
    @IBAction func btnPress(_ sender: Any) {
        scoreCount += 1
        score.text = "\(scoreCount)"
        
    }
    
    
    
}//vc

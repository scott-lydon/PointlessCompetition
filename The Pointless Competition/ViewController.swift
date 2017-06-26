
import UIKit
import FirebaseDatabase
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    @IBOutlet weak var score: UILabel!
    
    var scoreCount = 0
    var ref: DatabaseReference!
    let user = Auth.auth().currentUser
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
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
        
        let post : [String : Int] = ["Score" : scoreCount]
        self.ref.child("Users").child((user?.uid)!).setValue(post)
        
        let highScores = Database.database().reference().child("Users").queryOrdered(byChild: "score").queryLimited(toLast: 1)
        
        highScores.observeSingleEvent(of: .value, with: { (snapshot) in
            let alert = UIAlertController(title: "Alert", message: "leaderboard snapshot: \(snapshot)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }, withCancel: nil)
        
        
    }
    
    
    
}//vc

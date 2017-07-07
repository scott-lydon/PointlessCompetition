
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
    
    
    @IBAction func btnPress(_ sender: Any) {
        
        scoreCount += 1
        score.text = "\(scoreCount)"
        
        let post : [String : Int] = ["Score" : scoreCount]
        self.ref.child("Users").child((user?.uid)!).setValue(post)
        
    }
    
    @IBAction func scoreBoardPress(_ sender: Any) {
    }
    
    
}//vc

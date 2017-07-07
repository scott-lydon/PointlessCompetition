import UIKit
import FirebaseDatabase
import FirebaseAuth

class ScoreBoardTVC: UITableViewController {

    var receivedCount = Int()
    var highScores = DatabaseQuery()
    var snapShot = DataSnapshot()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellID")
        
        highScores = Database.database().reference().child("Users").queryOrdered(byChild: "score")//.queryLimited(toLast: 10000)
        highScores.observeSingleEvent(of: .value, with: { (snapshot) in
            self.snapShot = snapshot
            print(self.snapShot)
            let alert = UIAlertController(title: "Alert", message: "leaderboard snapshot: \(snapshot)", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }, withCancel: nil)

     
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
        cell.textLabel?.text = "hey"
        return cell
    }

}

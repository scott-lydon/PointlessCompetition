

import UIKit

class ScoreBoardTVC: UITableViewController {

    var receivedCount = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
         print(receivedCount)
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }


}

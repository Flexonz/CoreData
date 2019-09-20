import UIKit

class ToDoListViewController: UITableViewController {

    var data = ["D", "sd"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "shit", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addNewItemsButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create new", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertText) in
            alertText.placeholder = "Enter the name"
            textField = alertText
        }
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            self.data.append(textField.text!)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        present(alert, animated: true)
        
    }
}


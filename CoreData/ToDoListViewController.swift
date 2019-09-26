import UIKit

class ToDoListViewController: UITableViewController {
    var data = [Item]()
    let defaults = UserDefaults.standard
    
    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathExtension("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "shit", for: indexPath)
        let item = data[indexPath.row]
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.row].done = !data[indexPath.row].done
        tableView.deselectRow(at: indexPath, animated: true)
        saveItems()
    }
    
    @IBAction func addNewItemsButton(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Create new", message: "", preferredStyle: .alert)
        
        alert.addTextField { (alertText) in
            alertText.placeholder = "Enter the name"
            textField = alertText
        }
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            let item = Item(title: textField.text!, done: false)
            self.data.append(item)
            self.saveItems()
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func saveItems() {
        let encoder = PropertyListEncoder()
        do{
            let dats = try encoder.encode(data)
            try dats.write(to: filePath!)
        } catch {
            print ("Error encoding \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadItems() {
        if let dat = try? Data(contentsOf: filePath!) {
            let decoder = PropertyListDecoder()
            do {
            data = try decoder.decode([Item].self, from: dat)
            } catch {
                print ("Decoding error! \(error)")
            }
        }
    }
}


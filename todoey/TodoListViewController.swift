

import UIKit
import RealmSwift
class TodoListViewController: UITableViewController , UISearchBarDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate{
    var itemArray : Results<Item>? // 3amltha list 34an hst5dm el selectedCategory f load
    let realm = try! Realm()
    var selectedCategory : Category?{
        didSet{
           loadItems() // load data ellli 5asa b category dh
        }
    }
  
   var tf = UITextField()
    var tf2 = UITextField()

    override func viewDidLoad() {
        
        super.viewDidLoad()
     
    
        loadItems()

    }
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let edit = editAction(at:indexPath)
//        let delete = deleteAction(at:indexPath)
//        return UISwipeActionsConfiguration(actions: [delete,edit])
//    }
//    func editAction(at indexPath:IndexPath) -> UIContextualAction {
//
//        let action = UIContextualAction(style: .normal, title: "edit"){
//            (action,view,completion )in
//
//           self.itemArray[indexPath.row].setValue("self.tf2", forKey: "title")
//
//            self.saveItem()
//            completion(true)
//        }
//        action.image = UIImage (named: "edit")
//        action.backgroundColor = .green
//        return action
//    }
   // func deleteAction(at indexPath:IndexPath) -> UIContextualAction {
//        let action = UIContextualAction(style: .destructive, title: "Delete"){
//            (action,view,completion )in
//          
//            self.context.delete(self.itemArray[indexPath.row])//mohm gdn ashilo mn context el awel
//              self.itemArray.remove(at: indexPath.row)
//            self.saveItem()
//            completion(true)
//        }
//        action.image = UIImage (named: "delete")
//        action.backgroundColor = .red
     //   return action
  //  }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        if let item = itemArray?[indexPath.row]
        {
        cell.textLabel?.text = item.title
        
        if item.done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
            }}
        else{
            cell.textLabel?.text = "no item added yet"
        }
        print("ll")
        return cell
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if  let item = itemArray?[indexPath.row]{
            do{
                try self.realm.write { // save
                    
                   item.done = !item.done
                    
                    
                }
            }
            catch{print("error")}
            
        }
         self.tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBAction func addbutton(_ sender: UIBarButtonItem) {
        let alert =  UIAlertController(title: "add new todoey item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default ){(action)in
            
            if  let currentCategory = self.selectedCategory{
                do{
                    try self.realm.write { // save
                        let newItem = Item()
                        newItem.title = self.tf.text!
                        newItem.dataCreated = Date()
                   // newItem.done = false
                        // newItem.parentCategory = self.selectedCategory // dih bydif relation elli bano w ban el item
                   currentCategory.items.append( newItem)
                        
                    }
                }
                catch{print("error")}
            }
          self.tableView.reloadData()
         
        }
        alert.addTextField{(alertTextField)in
            alertTextField.placeholder = "create new item"
            self.tf =  alertTextField
        }
        alert.addAction(action)
        present (alert, animated: true,completion: nil)
    }

    func loadItems(){
     itemArray = selectedCategory?.items.sorted(byKeyPath: "dataCreated", ascending: true)
      



        tableView.reloadData()
   }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {//  dh search
        itemArray = itemArray?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "title", ascending: true)
        //m4 m7taga 23ml load

     tableView.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {//34an lma myob2a4 fih 7arf f search
            loadItems()
            tableView.reloadData()
            DispatchQueue.main.async { // satr dh 34an el cursur y5tafi
                
              searchBar.resignFirstResponder()
                
            }        }
    }
}


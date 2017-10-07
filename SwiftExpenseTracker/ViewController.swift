//
//  ViewController.swift
//  SwiftExpenseTracker
//
//  Created by Garrett Barker on 10/4/17.
//  Copyright © 2017 Garrett Barker. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let context = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    @IBOutlet var myTable: UITableView!
    
    var dataInfo: [Payments] = []
    var selectedObject: [Payments] = []
    var totalAmount = "Total: "
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return (dataInfo.count)
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "cell")
        cell.textLabel?.text = dataInfo[indexPath.row].name
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cell.detailTextLabel?.text = "$" + (NSString(format: "%.2f", (dataInfo[indexPath.row].amount as! Double) as CVarArg) as String)
        cell.detailTextLabel?.textColor = UIColor.red
     return cell
     }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedObject = [dataInfo[indexPath.row]]
        performSegue(withIdentifier: "addSegue", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getData()
        myTable.dataSource = self
        addTotalToNav()
        print(dataInfo as Any)
    }

    func addTotalToNav() -> Void {
        if let navigationBar = self.navigationController?.navigationBar {
            let totalFrame = CGRect(x: 10, y: 0, width: navigationBar.frame.width/2, height: navigationBar.frame.height)
            
            let totalLabel = UILabel(frame: totalFrame)
            totalLabel.text = totalAmount
            totalLabel.tag = 1
            totalLabel.font = UIFont.boldSystemFont(ofSize: 14)
            totalLabel.textColor = UIColor.red
            navigationBar.addSubview(totalLabel)
        }
    }
    
    func getData() -> Void {
        do{
            dataInfo = try context.fetch(Payments.fetchRequest())
            var total:Double = 0.00
            for i in 0 ..< dataInfo.count {
                total += dataInfo[i].amount as! Double
            }
            totalAmount = "Total: $" + (NSString(format: "%.2f", total as CVarArg) as String)
        }
        catch{
            print("Fetching Failed")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ViewControllerSecond
        vc.dataInfo = selectedObject
        selectedObject.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
        myTable.reloadData()
        if (self.navigationController?.navigationBar.viewWithTag(1)?.isHidden == true){
            self.navigationController?.navigationBar.viewWithTag(1)?.removeFromSuperview()
            addTotalToNav()
        }
    }
    
}


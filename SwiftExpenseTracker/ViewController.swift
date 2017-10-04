//
//  ViewController.swift
//  SwiftExpenseTracker
//
//  Created by Garrett Barker on 10/4/17.
//  Copyright © 2017 Garrett Barker. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let context = (UIApplication.shared.delegate as!
        AppDelegate).persistentContainer.viewContext
    
    var dataInfo: [Payments] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (dataInfo.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = dataInfo[indexPath.row].name
        return cell
    }
  /*
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "show", sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
  */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        getData()
       
        print(dataInfo as Any)
    }

    func getData() -> Void {
        do{
            dataInfo = try context.fetch(Payments.fetchRequest())
        }
        catch{
            print("Fetching Failed")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


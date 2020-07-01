//
//  ViewController.swift
//  Tong_URLConnection
//
//  Created by Tong Yi on 5/18/20.
//  Copyright © 2020 Tong Yi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NSURLConnectionDelegate, NSURLConnectionDataDelegate
{
    @IBOutlet var myTableView: UITableView!
    
    var dataSource = [Item]()
    var data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI()
    {
        
    }
    
    @IBAction func getButtonTapped(_ sender: Any)
    {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/todos") else { return }
        let request = URLRequest(url: url)
        let connection = NSURLConnection(request: request, delegate: self)!
//        connection.schedule(in: RunLoop.current, forMode: .default)
        connection.start()
    }
    
    @IBAction func downloadButtonTapped(_ sender: Any)
    {
        
    }
    
    func connection(_ connection: NSURLConnection, didReceive data: Data)
    {
//        let str = String(data: data, encoding: .utf8)
        self.data.append(data)
    }
    
    func connection(_ connection: NSURLConnection, didReceive response: URLResponse) {
//        self.data = NSMutableData()
        let statusCode = (response as! HTTPURLResponse).statusCode
        print(statusCode)
    }
    
//    func connection(_ connection: NSURLConnection, didFailWithError error: Error) {
//        <#code#>
//    }
    
    func connectionDidFinishLoading(_ connection: NSURLConnection) {
        do
        {
//            let json = try JSONSerialization.jsonObject(with: data as Data, options: .mutableContainers) as! [[String:Any]]
//
//            for item in json
//            {
//                let jsonDataUnit = Item(userId: item["userId"] as? Int ?? 0 ,
//                                        id: item["id"] as? Int ?? 0,
//                                        title: item["title"] as? String ?? "title",
//                                        completed: item["completed"] as? Bool ?? false)
//                self.dataSource.append(jsonDataUnit)
//            }
            
            self.dataSource = try JSONDecoder().decode([Item].self, from: data)
            self.myTableView.reloadData()
        }
        catch
        {
            print(error.localizedDescription)
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UrlConnectionCell", for: indexPath)
        cell.textLabel?.text = "Title: \(dataSource[indexPath.row].title)"
        cell.detailTextLabel?.text = "Complete: \(dataSource[indexPath.row].completed)"
        
        if indexPath.row % 3 == 0
        {
            cell.backgroundColor = UIColor(red: 200.0/255.0, green: 220.0/255.0, blue: 196.0/255.0, alpha: 1)
        }
        else
        {
            cell.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
        }
        return cell
    }
    
    
}


//
//  ViewController.swift
//  task2
//
//  Created by Volosandro on 31.10.2022.
//

import UIKit

class ViewController: UIViewController
{
    // MARK: - Variables
    var data = DataSource()
    var tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addTableView()
    }

    // MARK: - Configure
    func addTableView()
    {
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        self.view.addSubview(self.tableView)
    }
}

// MARK: - Extensions
extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.getDataCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")
        {
            cell.textLabel?.text = self.data.getStringByIndex(index: indexPath.row)
            cell.selectionStyle = .none
            return cell
        }
        else
        {
            return UITableViewCell()
        }
    }
}

extension ViewController: UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController()
        vc.title = self.data.getStringByIndex(index: indexPath.row)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

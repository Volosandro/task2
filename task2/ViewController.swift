//
//  ViewController.swift
//  task2
//
//  Created by Volosandro on 31.10.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    // MARK: - Variables
    var data = DataSource()
    var tableView = UITableView()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addTableView()
        self.tableView.reloadData()
    }
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        self.data = DataSource()
        self.tableView = UITableView()
    }
    
    override func encode(with coder: NSCoder) {
        coder.encode(self.data, forKey: "__data")
        coder.encode(self.tableView, forKey: "__tableView")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.data = coder.decodeObject(forKey: "__data") as! DataSource
        self.tableView = coder.decodeObject(forKey: "__tableView") as! UITableView
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Storage.shared.addVC(vc: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent
        {
            Storage.shared.removeVC(vc: self)
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ViewController()
        vc.title = self.data.getStringByIndex(index: indexPath.row)
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

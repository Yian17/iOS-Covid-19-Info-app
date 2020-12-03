//
//  NewsViewController.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-23.
//

import UIKit
import SnapKit
import HGPlaceholders

class NewsViewController: UIViewController {
    
    let newsViewModel: NewsViewModel = NewsViewModel()
    var placeholderTableView: TableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(NewsViewCell.self, forCellReuseIdentifier: "newsCell")
//        placeholderTableView?.showLoadingPlaceholder()
        
        placeholderTableView = tableView as? TableView
        placeholderTableView?.placeholderDelegate = self
        placeholderTableView?.showLoadingPlaceholder()
        
        self.title = "News"
        self.view.backgroundColor = .white
        
        self.edgesForExtendedLayout = UIRectEdge.bottom
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.equalTo(view.snp.left).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
        }
        setUpNavBar()
        
        newsViewModel.fetchNews { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success():
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private func setUpNavBar() {
//        navigationItem.title = "Feed"
        navigationController?.view.backgroundColor = UIColor.white
//        if #available(iOS 11.0, *) {
//            navigationController?.navigationBar.prefersLargeTitles = true
//        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.numOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath)
        
        guard let newsCell = cell as? NewsViewCell else {
            fatalError("no Cell")
        }
        newsCell.configure(newsModel: newsViewModel.getNews(indexPath: indexPath))
        return newsCell
    }
    
    
}

extension NewsViewController: PlaceholderDelegate {
    
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        print(placeholder.key.value)
        placeholderTableView?.showDefault()
    }

}

class ProjectNameTableView: TableView {
    override func customSetup() {
        placeholdersProvider = .basic
        
    }

}

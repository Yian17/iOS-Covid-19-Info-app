//
//  StatisticViewController.swift
//  Canada Covid-19 Info
//
//  Created by allets on 2020-11-18.
//

import UIKit
import SnapKit
import VegaScrollFlowLayout


class StatisticViewController: UIViewController {
    
    let statisticViewModel: StatisticViewModel = StatisticViewModel()
    let errorView: UIView = UIView()
    let refresher = UIRefreshControl()
    let refreshButton = UIButton()
    let subtitle = UILabel()
    
    private let collectionView: UICollectionView = {
        
        let layout = VegaScrollFlowLayout()
        layout.minimumLineSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 2 * 15, height: 100)
        //为什么不能在这里设置？frame。width
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StatisticCollectionViewCell.self, forCellWithReuseIdentifier: "StatisticCell")
        view.addSubview(collectionView)
        view.addSubview(subtitle)
        
        self.title = "Statistic"
//        self.navigationItem.setTitle(title: "Title", subtitle: "SubTitle")
        self.view.backgroundColor = .white
        setUpNavBar()
        
        self.edgesForExtendedLayout = UIRectEdge.bottom
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(0)
            make.left.equalTo(view.snp.left).offset(0)
            make.bottom.equalTo(view.snp.bottom).offset(0)
            make.right.equalTo(view.snp.right).offset(0)
        }
        
//        subtitle.text = "Covid cases of Canada from the past 7 days"
//        subtitle.snp.makeConstraints { (make) in
//            make.top.equalTo(view.snp.top).offset(0)
//            make.left.equalTo(view.snp.left).offset(10)
//        }
        
        refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        collectionView.addSubview(refresher)
        
        loadData()
    }
    
    private func setUpNavBar() {
//        navigationItem.title = "Feed"
        navigationController?.view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    @objc private func loadData() {
        if Reachability.isConnectedToNetwork() {
//            collectionViewFadeIn()
            collectionView.isHidden = false
            collectionViewFadeIn()
            fetchAndDisplayData()
        } else {
            collectionViewFadeOut()
            collectionView.isHidden = true
            refresher.endRefreshing()
            noInternetDisplay()
        }
    }
    
    private func fetchAndDisplayData() {
        statisticViewModel.fetchStatistic { (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success():
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.refresher.endRefreshing()
                }
            }
        }
    }
    
    private func noInternetDisplay() {
        errorView.isHidden = false
        view.addSubview(errorView)
        errorView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.bottom.equalTo(view.snp.bottom)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
        }
        
        let noInternetLabel = UILabel()
        noInternetLabel.text = "No Internet"
        errorView.addSubview(noInternetLabel)
        noInternetLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(errorView)
//            make.centerY.equalTo(view)
            make.top.equalTo(errorView).offset(UIScreen.main.bounds.height * 0.25)
        }
        noInternetLabel.textColor = .gray
        noInternetLabel.font = UIFont.systemFont(ofSize: 25)
        
//        let refreshButton = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        refreshButton.setTitle("Refresh", for: .normal)
//        refreshButton.backgroundColor = .blue
        refreshButton.setTitleColor(.blue, for: .normal)
        refreshButton.setTitleColor(.cyan, for: .highlighted)
        refreshButton.setTitleColor(.cyan, for: .selected)
//        refreshButton.setTitleColor(.cyan, for: .selected & .hi)
        
//        refreshButton.titleColor(for: .normal)
        refreshButton.addTarget(self, action: #selector(self.refresh), for: .touchUpInside)
        errorView.addSubview(refreshButton)
        refreshButton.snp.makeConstraints { (make) in
            make.top.equalTo(noInternetLabel.snp.bottom).offset(5)
            make.centerX.equalTo(errorView)
        }
        errorViewFadeIn()
    }
    
    private func errorViewFadeIn() {
        errorView.alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.errorView.alpha = 1
        }, completion: nil)
    }
    
    private func errorViewFadeOut() {
        errorView.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.errorView.alpha = 0
        }, completion: nil)
    }
    
    private func collectionViewFadeIn() {
        collectionView.alpha = 0.0
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.collectionView.alpha = 1
        }, completion: nil)
    }
    
    private func collectionViewFadeOut() {
        collectionView.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 1.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.collectionView.alpha = 0
        }, completion: nil)
    }
    
    @objc func refresh(sender: UIButton!) {
//        collectionView.reloadData()
//        refreshButton.setTitleColor(.cyan, for: .normal)
//        refreshButton.isSelected = !refreshButton.isSelected
        errorView.isHidden = true
//        errorViewFadeOut()
        loadData()
        print("==============refreshed===============")
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

extension StatisticViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return statisticViewModel.getNumOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StatisticCell", for: indexPath)
        
        guard let viewCell = cell as? StatisticCollectionViewCell else {
            fatalError("no cell")
        }
        viewCell.configure(model: statisticViewModel.getModel(indexPath: indexPath))
        
//        viewCell.contentView.layer.cornerRadius = 20
//        viewCell.contentView.layer.borderWidth = 5.0
        
        
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true

//        viewCell.contentView.layer.borderColor = UIColor.clear.cgColor
//        viewCell.contentView.layer.masksToBounds = true
        
        viewCell.backgroundColor = .white

        viewCell.layer.shadowColor = UIColor.black.cgColor
        viewCell.layer.shadowOffset = CGSize(width: 0, height: 0)
        viewCell.layer.shadowRadius = 3.5
        viewCell.layer.shadowOpacity = 0.3
        viewCell.layer.masksToBounds = false
        viewCell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return viewCell
    }
    
}

extension StatisticViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: collectionView.frame.width, height: 100)
//    }
}

extension UINavigationItem {



     func setTitle(title:String, subtitle:String) {

            let one = UILabel()
            one.text = title
            one.font = UIFont.systemFont(ofSize: 17)
            one.sizeToFit()

            let two = UILabel()
            two.text = subtitle
            two.font = UIFont.systemFont(ofSize: 12)
//            two.textAlignment = .center
            two.sizeToFit()



            let stackView = UIStackView(arrangedSubviews: [one, two])
            stackView.distribution = .equalCentering
            stackView.axis = .vertical
            stackView.alignment = .leading

            let width = max(one.frame.size.width, two.frame.size.width)
            stackView.frame = CGRect(x: 0, y: 0, width: width, height: 100)

//            one.sizeToFit()
//            two.sizeToFit()



            self.titleView = stackView
        }
    }

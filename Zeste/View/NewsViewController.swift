//
//  NewsViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/11/11.
//

import UIKit

class NewsViewController: BaseViewController {
    
    var newsArr : [String] = []
    var imgArr : [String] = ["quiz_0","quiz_1","quiz_2","quiz_3","quiz_4","quiz_5"]
    let tv = UITableView().then {
        $0.backgroundColor = .white
        $0.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.registerID)
    }
    
    var newsList : [NewsData] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "제로웨이스트 핫이슈🔥"
        
        //tabel view setting
        setTableView()
        initVC()
        bindConstraints()
        setBarButton()
        
        NewsDataManager().getNewsList(viewController: self)
    }
}

extension NewsViewController {
    
    private func initVC() {
        self.view.addSubview(tv)
    }
    private func bindConstraints() {
        tv.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setBarButton() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            //.viewfinder
            image: UIImage(systemName: "brain.head.profile"),
            style: .plain,
            target: self,
            action: #selector(quizTapped)
        )
    }
    
    private func setTableView() {
        self.tv.delegate = self
        self.tv.dataSource = self
        // 나머지 구분선 안보이게 (개수만큼만 보여)
        self.tv.tableFooterView = UIView()
        // autoHeight
        self.tv.rowHeight = UITableView.automaticDimension
        self.tv.estimatedRowHeight = 35
    }
}

extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.registerID, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        myCell.newsLabel.text = "\"\(newsList[indexPath.row].nTitle)\""
        myCell.tagLabel.text = "\(newsList[indexPath.row].tag)"
        myCell.newsImg.image = UIImage(named: "\(imgArr[indexPath.row])")
        cell = myCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: "\(newsList[indexPath.row].link)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
}


extension NewsViewController {
    @objc func quizTapped() {
        let nextVC = QuizViewController()
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: false)
    }
}

extension NewsViewController {
    func didSuccess(result : NewsDataModel) {
        print(result.results)
        newsList = result.results
        tv.reloadData()
    }
    func failedToRequest(message : String) {
        self.presentAlert(title: message)
    }
}

//
//  NewsViewController.swift
//  Zeste
//
//  Created by miori Lee on 2021/11/11.
//

import UIKit

class NewsViewController: BaseViewController {
    
    var newsArr : [String] = []
    let tv = UITableView().then {
        $0.backgroundColor = .white
        $0.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.registerID)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.title = "제로웨이스트 핫이슈🔥"
        
        //tabel view setting
        setTableView()
        initVC()
        bindConstraints()
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
    
    private func setTableView() {
        self.tv.delegate = self
        self.tv.dataSource = self
        // 나머지 구분선 안보이게 (개수만큼만 보여)
        self.tv.tableFooterView = UIView()
        // autoHeight
        self.tv.rowHeight = UITableView.automaticDimension
        self.tv.estimatedRowHeight = 40
    }
}

extension NewsViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let myCell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.registerID, for: indexPath) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        myCell.newsLabel.text = "newsLabel\(indexPath.row)"
        myCell.tagLabel.text = "#태그1 #태그2 #태그3 #태그4 #태그5 #태그5 #태그7"
        cell = myCell
        return cell
    }
    
    
}

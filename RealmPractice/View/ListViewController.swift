//
//  ViewController.swift
//  RealmPractice
//
//  Created by TAEHYOUNG KIM on 1/13/24.
//

import UIKit
import CoreLocation
import Combine

import RealmSwift
import SnapKit

class ListViewController: UIViewController {
    var tableView: UITableView!
    var vm: ListViewModel!
    var subscriptions = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        vm = ListViewModel()
        view.backgroundColor = .systemBackground
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Stored Data"
        setupTableView()
        createBarButtonItem()
        vm.addChangeListener(tableView)
    }

    func createBarButtonItem() {
        let image = UIImage(systemName: "play")
        let item = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(action))

        navigationItem.rightBarButtonItem = item
    }

    @objc func action() {
        vm.addItem()
    }

    func setupTableView() {
        tableView = UITableView(frame: .zero)
        tableView.register(ListCell.self, forCellReuseIdentifier: "ListCell")
        tableView.dataSource = self
        tableView.delegate = self
        setTableViewSeparator()

        view.addSubview(tableView)
        setTableViewConstraints()

        func setTableViewSeparator() {
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = .brown
            tableView.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)
        }

        func setTableViewConstraints() {
            tableView.snp.makeConstraints { make in
                make.edges.equalTo(view)
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm.trackingDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as? ListCell else { return UITableViewCell() }
        let item = vm.trackingDatas[indexPath.row]
        cell.configure(item: item)
        cell.selectionStyle = .none
        return cell
    }
}

extension ListViewController: UITableViewDelegate {

}


/// 테스트 계획
/// Add를 했을 때, 리스트에 렘에 저장한 객체들을 보여준다.
///
/// 세부 계획
/// ✅ 역지오코딩 리턴값이 렘에 잘 저장되는가?
///
/// ✅ 1. 테이블뷰 만들고
///   셀에 start-end Place / 시간 보여주기
///
/// ✅ 2. Add 시 createDate, random coordinate 객체에 추가하기




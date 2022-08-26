//
//  TableVC.swift
//  TestProject
//
//  Created by Dmitriy Eni on 24.08.2022.
//

import UIKit

class TableVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    var page = 0
    var profiles = [Profile]()
    let imagePicker = UIImagePickerController()
    let vc = PhotoVC(nibName: String(describing: PhotoVC.self), bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerController.SourceType.camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.modalPresentationStyle = .fullScreen
        
        let nib = UINib(nibName: String(describing: Cell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: Cell.self))
        
        spiner.startAnimating()
        NetworkManager.getUsers(pagination: false, page: page) { [weak self] profiles in
            self?.profiles.append(contentsOf: profiles)
            self?.spiner.stopAnimating()
            self?.tableView.reloadData()
            self?.page += 1
            isPagination = false
        } failureBlock: {
            self.spiner.stopAnimating()
        }
    }
    func createSpinerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let footerSpiner = UIActivityIndicatorView()
        footerSpiner.center = footerView.center
        footerView.addSubview(footerSpiner)
        footerSpiner.startAnimating()
        
        return footerView
    }
}

extension TableVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profiles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: Cell.self), for: indexPath) as! Cell
        cell.setupCell(profile: profiles[indexPath.row])
        return cell
    }
}

extension TableVC: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.page > 0, self.page < totalPage {
            let position = scrollView.contentOffset.y
            if position > (tableView.contentSize.height-scrollView.frame.size.height-100) {
                guard !isPagination else { return }
                self.tableView.tableFooterView = createSpinerFooter()
                NetworkManager.getUsers(pagination: true, page: page) { profiles in
                    self.tableView.tableFooterView = nil
                    self.profiles.append(contentsOf: profiles)
                    self.tableView.reloadData()
                    self.page += 1
                    isPagination = false
                } failureBlock: {
                    
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        present(imagePicker, animated: true, completion: nil)
    }
}

extension TableVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerOriginalImage")] as? UIImage {
            vc.tmpImage = image
        }
        picker.dismiss(animated: true)
        navigationController?.pushViewController(vc, animated: true)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

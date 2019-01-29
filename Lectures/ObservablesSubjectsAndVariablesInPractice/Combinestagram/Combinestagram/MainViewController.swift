import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var itemAdd: UIBarButtonItem!
    
    let bag = DisposeBag()
    let ads: BehaviorRelay<[UIImage]> = BehaviorRelay(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ads.asDriver().drive(onNext: { [weak self] image in
            guard let self = self else { return }
            guard let preview = self.imagePreview else { return }
            
            self.updateUI(photos: image)
            preview.image = UIImage.collage(images: image, size: preview.frame.size)
        })
        .disposed(by: bag)
    }
    
    func updateUI(photos: [UIImage]) {
        buttonSave.isEnabled =  photos.count > 0 && photos.count % 2 == 0
        buttonClear.isEnabled = photos.count > 0
        itemAdd.isEnabled = photos.count < 6
        title = photos.count > 0 ? "\(photos.count) photos" : "Collage"
    }
    
    @IBAction func actionClear() {
        ads.accept([])
    }
    
    @IBAction func actionSave() {
        guard let image = imagePreview.image else { return }
        
        PhotoWriter.save(image)
            .subscribe(onSuccess: { [weak self] id in
                self?.showMessage("Save with id: \(id)")
                self?.actionClear()
                }, onError: { [weak self] error in
                    self?.showMessage("Error", description: error.localizedDescription)
            })
            .disposed(by: bag)
    }
    
    @IBAction func actionAdd() {
        let photosViewController = storyboard?.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
        
        photosViewController.selectedPhotos
            .subscribe(onNext: { [weak self] newImage in
                guard let ads = self?.ads else { return }
                var arr = ads.value
                arr.append(newImage)
                ads.accept(arr)
                }, onDisposed: {
                    print("Complete \(self.ads.value.count) Photos selection")
            })
            .disposed(by: bag)
        
        navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    func showMessage(_ title: String, description: String? = nil) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default, handler: { [weak self] _ in self?.dismiss(animated: true, completion: nil)}))
        present(alert, animated: true, completion: nil)
    }
}


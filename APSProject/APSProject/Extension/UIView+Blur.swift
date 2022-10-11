
import UIKit

//extension RecoCollectionView {
//    public func blurEffect(bg : UIImageView, context : CIContext) {
//
//        let currentFilter = CIFilter(name: "CIGaussianBlur")
//        let beginImage = CIImage(image: bg.image!)
//        currentFilter!.setValue(beginImage, forKey: kCIInputImageKey)
//        currentFilter!.setValue(10, forKey: kCIInputRadiusKey)
//
//        let cropFilter = CIFilter(name: "CICrop")
//        cropFilter!.setValue(currentFilter!.outputImage, forKey: kCIInputImageKey)
//        cropFilter!.setValue(CIVector(cgRect: beginImage!.extent), forKey: "inputRectangle")
//
//        let output = cropFilter!.outputImage
//        let cgimg = context.createCGImage(output!, from: output!.extent)
//        let processedImage = UIImage(cgImage: cgimg!)
//        bg.image = processedImage
//    }
//}

import SwiftUI
import PDFKit

struct PDFKitView: UIViewRepresentable {
    
    let pdfDocument: PDFDocument
    
    init(showing pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }
    
    //you could also have inits that take a URL or Data
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}

struct PDFUIView: View {
    
    let pdfDoc: PDFDocument
    
    init(name: String) {
        let url = Bundle.main.url(forResource: name, withExtension: "pdf")!
        pdfDoc = PDFDocument(url: url)!
    }
    
    var body: some View {
        PDFKitView(showing: pdfDoc)

    }
}

struct PDFUIView_Previews: PreviewProvider {
    static var previews: some View {
        PDFUIView(name: "Lipsum")
    }
}
